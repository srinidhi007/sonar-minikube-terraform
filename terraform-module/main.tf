resource "helm_release" "postgresql" {
  name       = var.postgresql_release_name
  repository = var.postgresql_chart_repository
  chart      = var.postgresql_chart
  version    = "16.4.5"
  namespace  = var.namespace

  set {
    name  = "auth.username"
    value = var.postgresql_username
  }

  set {
    name  = "auth.password"
    value = var.postgresql_password
  }

  set {
    name  = "auth.database"
    value = var.postgresql_database
  }
}

# Deploy SonarQube with PostgreSQL
resource "helm_release" "sonarqube" {
  name       = var.sonarqube_release_name
  repository = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart      = var.sonarqube_chart
  namespace  = var.namespace
  depends_on = [helm_release.postgresql]

  set {
    name  = "postgresql.enabled"
    value = "false"
  }

  # Correct PostgreSQL configuration
  set {
    name  = "jdbcOverwrite.enabled"
    value = "true"
  }

  set {
    name  = "jdbcOverwrite.jdbcUrl"
    value = "jdbc:postgresql://${var.postgresql_server}:5432/${var.postgresql_database}"
  }

  set {
    name  = "jdbcOverwrite.jdbcUsername"
    value = var.postgresql_username
  }

  set {
    name  = "jdbcOverwrite.jdbcPassword"
    value = var.postgresql_password
  }

  # Enable ingress
  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.hosts[0].name"
    value = "sonarqube.local"
  }

  set {
    name  = "ingress.hosts[0].path"
    value = "/"
  }

  set {
    name  = "ingress.ingressClassName"
    value = "nginx"
  }

  # Enable persistence
  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.storageClass"
    value = "standard"
  }

  set {
    name  = "persistence.size"
    value = "10Gi"
  }

  set {
    name  = "monitoringPasscode"
    value = var.sonarqube_monitoring_passcode
  }

  set {
    name  = "community.enabled"
    value = "true"
  }
}
