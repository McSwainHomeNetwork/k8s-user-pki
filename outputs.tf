output "ci_user_cert_pem" {
  value     = tls_locally_signed_cert.ci_user_cert.cert_pem
  sensitive = true
}

output "ci_user_key_pem" {
  value     = tls_private_key.ci_user_key.private_key_pem
  sensitive = true
}

output "admin_user_cert_pem" {
  value     = tls_locally_signed_cert.admin_user_cert.cert_pem
  sensitive = true
}

output "admin_user_key_pem" {
  value     = tls_private_key.admin_user_key.private_key_pem
  sensitive = true
}
