terraform {
  required_providers {
    local = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}

resource "tls_private_key" "admin_user_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_cert_request" "admin_user_csr" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.admin_user_key.private_key_pem

  subject {
    # User in k8s
    common_name = "admin"
    # Groups in k8s, can add multiple
    organization = "system:masters"
  }
}

resource "tls_locally_signed_cert" "admin_user_cert" {
  cert_request_pem   = tls_cert_request.admin_user_csr.cert_request_pem
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = var.ca_private_key_pem
  ca_cert_pem        = var.ca_cert_pem

  # 5 years. This is a long-lived cluster and a tightly
  # secured certificate
  validity_period_hours = 43800

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth",
    "client_auth",
  ]
}

resource "tls_private_key" "ci_user_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_cert_request" "ci_user_csr" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.ci_user_key.private_key_pem

  subject {
    # User in k8s
    common_name = "ci"
    # Groups in k8s, can add multiple
    organization = "system:masters"
  }
}

resource "tls_locally_signed_cert" "ci_user_cert" {
  cert_request_pem   = tls_cert_request.ci_user_csr.cert_request_pem
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = var.ca_private_key_pem
  ca_cert_pem        = var.ca_cert_pem

  # Short validity. Since other Terraform Cloud workflows reference the output, we can always re-apply to regenerate if needed.
  validity_period_hours = 12

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth",
    "client_auth",
  ]
}
