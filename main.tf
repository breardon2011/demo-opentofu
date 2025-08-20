terraform {
  required_version = ">= 1.3.0"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

locals {
  # Paste ONE project ID per line in this heredoc (no emojis/status cols needed).
  raw = <<EOT
projects_kx7m9n2p4q
projects_w8z3b5j6r9
projects_f4h7k9m2p8
projects_q1v5x8c3n7
projects_j6r9t2w5z8
projects_m3p6s9v2y5
projects_h8k1n4q7t0
projects_c5f8j1m4p7
projects_x2z5b8e1h4
projects_n7q0t3w6z9
projects_g4j7m0p3s6
projects_l9o2r5u8x1
projects_d6g9j2m5p8
projects_y3b6e9h2k5
projects_v0z3c6f9i2
projects_r5u8x1a4d7
projects_s8v1y4b7e0
projects_p3s6v9y2b5
projects_k8n1q4t7w0
projects_i3l6o9r2u5
projects_a8d1g4j7m0
projects_e3h6k9n2q5
projects_t8w1z4c7f0
projects_o5r8u1x4a7
projects_b0e3h6k9n2
projects_z5c8f1i4l7
projects_u0x3a6d9g2
projects_q5t8w1z4c7
projects_m0p3s6v9y2
projects_h5k8n1q4t7
projects_c0f3i6l9o2
projects_x5a8d1g4j7
projects_s0v3y6b9e2
projects_n5q8t1w4z7
projects_j0m3p6s9v2
projects_f5i8l1o4r7
projects_b0e3h6k9n2
projects_w7z0c3f6i9
projects_r2u5x8a1d4
projects_l7o0r3u6x9
projects_g2j5m8p1s4
projects_d7g0j3m6p9
projects_y2b5e8h1k4
projects_t7w0z3c6f9
projects_o2r5u8x1a4
projects_k7n0q3t6w9
projects_f2i5l8o1r4
projects_a7d0g3j6m9
projects_v2y5b8e1h4
projects_q7t0w3z6c9
projects_l2o5r8u1x4
projects_h7k0n3q6t9
projects_c2f5i8l1o4
projects_x7a0d3g6j9
projects_s2v5y8b1e4
projects_n7q0t3w6z9
projects_i2l5o8r1u4
projects_e7h0k3n6q9
projects_z2c5f8i1l4
projects_u7x0a3d6g9
projects_p2s5v8y1b4
projects_k7n0q3t6w9
projects_g2j5m8p1s4
projects_b7e0h3k6n9
projects_w2z5c8f1i4
projects_r7u0x3a6d9
projects_m2p5s8v1y4
projects_h7k0n3q6t9
projects_d2g5j8m1p4
projects_y7b0e3h6k9
projects_t2w5z8c1f4
projects_o7r0u3x6a9
projects_j2m5p8s1v4
projects_e7h0k3n6q9
projects_z2c5f8i1l4
projects_v7y0b3e6h9
projects_q2t5w8z1c4
projects_l7o0r3u6x9
projects_g2j5m8p1s4
projects_c7f0i3l6o9
projects_x2a5d8g1j4
projects_s7v0y3b6e9
projects_n2q5t8w1z4
projects_i7l0o3r6u9
projects_d2g5j8m1p4
projects_z7c0f3i6l9
projects_u2x5a8d1g4
projects_p7s0v3y6b9
projects_k2n5q8t1w4
projects_f7i0l3o6r9
projects_a2d5g8j1m4
projects_w7z0c3f6i9
projects_r2u5x8a1d4
projects_m7p0s3v6y9
projects_h2k5n8q1t4
projects_c7f0i3l6o9
projects_y2b5e8h1k4
projects_t7w0z3c6f9
projects_o2r5u8x1a4
projects_j7m0p3s6v9
projects_e2h5k8n1q4
projects_a7d0g3j6m9
projects_v2y5b8e1h4
projects_q7t0w3z6c9
projects_l2o5r8u1x4
projects_g7j0m3p6s9
projects_c2f5i8l1o4
projects_x7a0d3g6j9
projects_s2v5y8b1e4
projects_n7q0t3w6z9
projects_i2l5o8r1u4
projects_e7h0k3n6q9
projects_z2c5f8i1l4
projects_u7x0a3d6g9
projects_p2s5v8y1b4
projects_k7n0q3t6w9
projects_f2i5l8o1r4
projects_b7e0h3k6n9
projects_w2z5c8f1i4
projects_r7u0x3a6d9
projects_m2p5s8v1y4
projects_h7k0n3q6t9
projects_d2g5j8m1p4
projects_y7b0e3h6k9
projects_t2w5z8c1f4
projects_o7r0u3x6a9
projects_j2m5p8s1v4
projects_f7i0l3o6r9
projects_a2d5g8j1m4
projects_v7y0b3e6h9
projects_q2t5w8z1c4
projects_l7o0r3u6x9
projects_g2j5m8p1s4
projects_c7f0i3l6o9
projects_x2a5d8g1j4
projects_s7v0y3b6e9
projects_n2q5t8w1z4
projects_i7l0o3r6u9
projects_e2h5k8n1q4
projects_z7c0f3i6l9
projects_u2x5a8d1g4
projects_p7s0v3y6b9
projects_k2n5q8t1w4
projects_f7i0l3o6r9
projects_b2e5h8k1n4
projects_w7z0c3f6i9
projects_r2u5x8a1d4
projects_m7p0s3v6y9
projects_h2k5n8q1t4
projects_d7g0j3m6p9
projects_y2b5e8h1k4
projects_t7w0z3c6f9
projects_o2r5u8x1a4
projects_j7m0p3s6v9
projects_e2h5k8n1q4
projects_a7d0g3j6m9
EOT

  # Split into non-empty lines
  lines = compact(split("\n", trimspace(local.raw)))

  # Build a map of safe Terraform keys -> original names
  # sanitize: spaces, '/', '-', '.', ':' -> '_'
  items = {
    for idx, name in local.lines :
    format("r%04d_%s",
      idx,
      replace(
        replace(
          replace(
            replace(
              replace(name, " ", "_"),
            "/", "_"),
          "-", "_"),
        ".", "_"),
      ":", "_")
    ) => name
  }
}

resource "null_resource" "test" {
  for_each = local.items

  # Keep the original string visible in state
  triggers = {
    original = each.value
  }
}

output "count_created" {
  value = length(local.items)
}

output "example_names" {
  value = slice(keys(local.items), 0, min(5, length(local.items)))
}
