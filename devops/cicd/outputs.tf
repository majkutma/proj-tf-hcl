output "terraform-workspace" {
  description = "The terraform workspace"
  value       = terraform.workspace
}
output "git-branch-name" {
  description = "The Git branch name"
  value       = var.GIT_BRANCH_NAME
}
