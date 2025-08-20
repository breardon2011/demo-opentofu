#!/usr/bin/env bash
set -euo pipefail

TF_FILE="${1:-main.tf}"      # Terraform file that contains locals.raw <<EOT ... EOT
OUT_BASE="${2:-.}"           # Base directory to create project folders
DIGGER_YML="${3:-digger.yml}"

[ -f "$TF_FILE" ] || { echo "❌ Cannot find Terraform file: $TF_FILE"; exit 1; }

# --- Extract project IDs between:  raw = <<EOT   ...   EOT  -------------------
projects_tmp="$(mktemp)"
awk '
  BEGIN { inside=0 }
  /^[[:space:]]*raw[[:space:]]*=[[:space:]]*<<EOT[[:space:]]*$/ { inside=1; next }
  inside && /^[[:space:]]*EOT[[:space:]]*$/ { inside=0; next }
  inside { print }
' "$TF_FILE" \
| sed -e 's/\r$//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' \
| grep -vE '^$|^#' \
> "$projects_tmp"

# Deduplicate
sort -u -o "$projects_tmp" "$projects_tmp"

# --- Prepare digger.yml --------------------------------------------------------
ts="$(date +%s)"
if [ -f "$DIGGER_YML" ]; then
  cp -f "$DIGGER_YML" "$DIGGER_YML.bak.$ts"
fi

cat > "$DIGGER_YML" <<'YML'
auto_merge: true
auto_merge_strategy: "merge"
delete_prior_comments: true

projects:
YML

# --- Helper: sanitize to Terraform label (letters/digits/underscore only) -----
sanitize_tf_id() {
  id="$(printf '%s' "$1" | tr -c 'A-Za-z0-9_' '_' )"
  case "$id" in
    [0-9]*) id="_$id" ;;
  esac
  printf '%s' "$id"
}

# --- Create dirs + main.tf; append to digger.yml -------------------------------
count=0
while IFS= read -r name; do
  [ -z "$name" ] && continue

  dir="$OUT_BASE/$name"
  mkdir -p "$dir"

  tf_id="$(sanitize_tf_id "$name")"
  cat > "$dir/main.tf" <<HCL
# GENERATED placeholder for $name
terraform {
  required_version = ">= 1.3.0"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}
resource "null_resource" "$tf_id" {
  triggers = { project_name = "$name" }
}
HCL

  printf "  - name: %s\n    dir: %s/\n" "$name" "$name" >> "$DIGGER_YML"
  count=$((count+1))
done < "$projects_tmp"

cat >> "$DIGGER_YML" <<'YML'

workflows:
  default:
    plan:
      steps:
        - init
        - run: terraform plan -input=false -refresh -no-color -out $DIGGER_PLANFILE
YML

rm -f "$projects_tmp"

echo "✅ Created $count project directories with null_resource main.tf under: $OUT_BASE"
if [ -f "$DIGGER_YML.bak.$ts" ]; then
  echo "✅ Updated $DIGGER_YML (backup: $DIGGER_YML.bak.$ts)"
else
  echo "✅ Wrote $DIGGER_YML"
fi
