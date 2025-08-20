#!/usr/bin/env bash
set -euo pipefail

# ---- config ----
N=${N:-20}
OWNER=${OWNER:-breardon2011}
REPO=${REPO:-demo-opentofu}
LABELS=${LABELS:-self-hosted,macOS,ARM64,dev}
VERSION=${VERSION:-2.328.0}
BASE=${BASE:-"$HOME/actions-runners"}
EPHEMERAL=${EPHEMERAL:-0}         # 1=ephemeral (one job), 0=persistent service

command -v gh >/dev/null || { echo "Install GitHub CLI: brew install gh"; exit 1; }
gh auth status -h github.com >/dev/null || { echo "Run: gh auth login"; exit 1; }

range() { if command -v seq >/dev/null; then seq 1 "$1"; elif command -v jot >/dev/null; then jot - 1 "$1"; else i=1; while [ "$i" -le "$1" ]; do echo "$i"; i=$((i+1)); done; fi; }

mkdir -p "$BASE/_cache"
ARCHIVE="$BASE/_cache/actions-runner-osx-arm64-${VERSION}.tar.gz"

# --- download ONCE into cache ---
if [ ! -f "$ARCHIVE" ]; then
  echo "⬇️  Downloading runner ${VERSION} once to cache..."
  curl -L -o "$ARCHIVE" "https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-osx-arm64-${VERSION}.tar.gz"
else
  echo "✅ Using cached runner: $ARCHIVE"
fi

for i in $(range "$N"); do
  DIR="$BASE/runner-$i"
  mkdir -p "$DIR"
  pushd "$DIR" >/dev/null

  # extract only if not already extracted
  if [ ! -x "./bin/Runner.Listener" ]; then
    echo "📦 Extracting into $DIR"
    tar xzf "$ARCHIVE"
  fi

  # (Optional) check version; skip re-extract if already matches
  if ./bin/Runner.Listener --version 2>/dev/null | grep -q "$VERSION"; then :; else
    echo "♻️  Runner version mismatch; re-extracting..."
    rm -rf ./bin ./externals ./run.sh ./config.sh ./state.json ./.credentials* ./.runner || true
    tar xzf "$ARCHIVE"
  fi

  # get short-lived registration token
  TOKEN=$(gh api -X POST "repos/$OWNER/$REPO/actions/runners/registration-token" --jq .token)

  # common config args
  CFG_ARGS=(
    --url "https://github.com/$OWNER/$REPO"
    --token "$TOKEN"
    --name "$(hostname)-$i"
    --labels "$LABELS"
    --work "_work-$i"
    --unattended
    --disableupdate          # don't auto-download a newer runner
    --replace                # idempotent reconfig
  )

  if [ "$EPHEMERAL" = "1" ]; then
    ./config.sh "${CFG_ARGS[@]}" --ephemeral
    nohup ./run.sh >/dev/null 2>&1 &
  else
    ./config.sh "${CFG_ARGS[@]}"
    ./svc.sh install || true
    ./svc.sh start   || true
  fi

  popd >/dev/null
done

echo "🚀 Launched $N runner(s). Cache: $ARCHIVE"
