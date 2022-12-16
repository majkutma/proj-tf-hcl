variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}
variable "AWS_ACCESS_KEY_ID" {
  type = string
}
variable "git_branch_name" {
  default = "main"
  type = string
  description = "The Git branch name"
}