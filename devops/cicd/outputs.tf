output "terraform-workspace" {
  description = "The terraform workspace"
  value       = terraform.workspace
}
output "git-branch-name" {
  description = "The Git branch name"
  value       = var.git-branch-name
}
output "terraform-branch-name" {
  description = "The terraform workspace"
  value       = terraform.branch
}
