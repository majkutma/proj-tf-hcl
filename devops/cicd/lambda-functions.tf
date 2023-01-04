module "my-lambda-function-id" {
  source = "./modules/resource-id"
  branch-name = var.GIT_BRANCH_NAME
  resource-name = "my-lambda-function"
}
data "archive_file" "zipit" {
  type = "zip"
  source_dir = "../lambda-dist/my-integration-lambda/dist"
  output_path = "tf-lambda.zip"
}
resource "aws_lambda_function" "my-lambda-function" {
  function_name = module.my-lambda-function-id.resource-id
  role = aws_iam_role.my-iam-role.arn
  filename = "tf-lambda.zip"
  handler = "dist/app.lambdaHandler"
  runtime = "nodejs18.x"
}
