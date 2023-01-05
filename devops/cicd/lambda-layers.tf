module "my_lambda_layer_id" {
  source = "./modules/resource-id"
  branch_name = var.GIT_BRANCH_NAME
  resource_name = "my-lambda-layer"
}
# data "archive_file" "zip-layer" {
#   type = "zip"
#   source_dir = "../lambda-dist/my-lambda-layer"
#   output_path = "my-lambda-layer.zip"
# }
resource "aws_lambda_layer_version" "my_lambda_layer" {
  layer_name = module.my_lambda_layer_id.resource_id
  filename   = "../lambda-dist/node-modules.zip"
  compatible_runtimes = ["nodejs18.x"]
}