module "my-s3-bucket-id" {
  source = "./modules/resource-id"
  branch-name = var.GIT_BRANCH_NAME
  resource-name = "my-s3-bucket"
}
resource "aws_s3_bucket" "my-s3-bucket" {
  bucket = module.my-s3-bucket-id.resource-id
}
resource "aws_s3_bucket_acl" "my-s3-bucket-acl" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  acl    = "private"
}
