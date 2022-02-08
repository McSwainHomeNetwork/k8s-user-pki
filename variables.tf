variable "ca_cert_pem" {
  type        = string
  sensitive   = true
  description = "PEM-formatted CA cert to derive K8S users from."
}

variable "ca_private_key_pem" {
  type        = string
  sensitive   = true
  description = "PEM-formatted CA private key to derive K8S users with."
}
