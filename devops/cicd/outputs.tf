output "terraform_workspace" {
  description = "The terraform workspace"
  value       = terraform.workspace
}
output "git_branch_name" {
  description = "The Git branch name"
  value       = var.GIT_BRANCH_NAME
}
