variable "region" {
  default = "us-east-1"
  type = string
  description = "The region you want to deploy the infrastructure in"
}

variable "rds_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "docudb_password" {
  description = "Document DB root user password"
  type        = string
  sensitive   = true
}