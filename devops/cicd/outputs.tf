output "terraform_workspace" {
  description = "The terraform workspace"
  value       = terraform.workspace
}
output "my_s3_bucket_id" {
  value = module.my_s3_bucket_id.resource_id
}