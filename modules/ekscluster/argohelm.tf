
# Install ArgoCD Helm Chart
resource "helm_release" "argocd" {
  name  = "argocd"

  repository       = var.argocd_repo
  chart            = var.argocd_chart
  namespace        = var.argocd_namespace
  version          = var.argocd_version
  create_namespace = var.argocd_create_namespace

  values = [
    file(var.argocd_application_path)
  ]
}
data "aws_ssm_parameter" "ssh_private_key" {
  name = var.ssh_parameter_name
}
resource "kubernetes_secret" "ssh_key" {
  depends_on = [helm_release.argocd]
  
  metadata {
    name      = "private-repo"
    namespace = var.argocd_namespace
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  type = "Opaque"

  data = {
    "sshPrivateKey" = data.aws_ssm_parameter.ssh_private_key.value
    "type"          = var.argocd_repo_type
    "url"           = var.argocd_repo_url
    "name"          = var.argocd_repo_place
    "project"       = "*"
  }
}