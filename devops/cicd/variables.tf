# variable "AWS_SECRET_ACCESS_KEY" {
#   type = string
#   description = "The AWS Account secret access key"
# }
# variable "AWS_ACCESS_KEY_ID" {
#   type = string
#   description = "The AWS Account access key ID"
# }
variable "git-branch-name" {
  default = "main"
  type = string
  description = "The Git branch name"
}
variable "REPOSITORY_URL" {
  default = "https://github.com/majkutma/proj-tf-hcl"
  type = string
  description = "The GitHub Repository URL"
}
variable "REPOSITORY_FOLDER_PATH" {
  default = "frontend"
  type = string
  description = "The GitHub Repository folder path"
}
variable "REPOSITORY_ACCESS_TOKEN" {
  type = string
  description = "The GitHub Repository access token"
}