module "my_s3_bucket_id" {
  source        = "./modules/resource-id"
  branch_name   = var.GIT_BRANCH_NAME
  resource_name = "my-s3-bucket"
}
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = module.my_s3_bucket_id.resource_id
}
resource "aws_s3_bucket_acl" "my_s3_bucket_acl" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  acl    = "private"
}
