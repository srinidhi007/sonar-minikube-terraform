variable "postgresql_username" {
  description = "Username for the PostgreSQL database"
  type        = string
}

variable "postgresql_password" {
  description = "Password for the PostgreSQL database"
  type        = string
}

variable "postgresql_database" {
  description = "Database name for SonarQube"
  type        = string
}

variable "postgresql_chart" {
  description = "Helm chart for PostgreSQL"
  type        = string
  default     = "postgresql"
}

variable "postgresql_release_name" {
  description = "Helm release name for PostgreSQL"
  type        = string
  default     = "postgresql"
}

variable "sonarqube_chart" {
  description = "Helm chart for SonarQube"
  type        = string
  default     = "sonarqube"
}

variable "sonarqube_release_name" {
  description = "Helm release name for SonarQube"
  type        = string
  default     = "sonarqube"
}

variable "namespace" {
  description = "Kubernetes namespace to deploy resources"
  type        = string
  default     = "default"
}

variable "postgresql_chart_repository" {
  description = "Repository for the PostgreSQL Helm chart"
  type        = string
  default     = "oci://registry-1.docker.io/bitnamicharts"
}

variable "sonarqube_monitoring_passcode" {
  description = "The monitoring passcode for SonarQube"
  type        = string
}

variable "postgresql_server" {
  description = "The address of the PostgreSQL server"
  type        = string
}
