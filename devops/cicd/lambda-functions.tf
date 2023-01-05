module "my_lambda_function_id" {
  source = "./modules/resource-id"
  branch_name = var.GIT_BRANCH_NAME
  resource_name = "my-lambda-function"
}
data "archive_file" "zipit" {
  type = "zip"
  source_dir = "../lambda-dist/my-integration-lambda/dist"
  output_path = "tf-lambda.zip"
}
resource "aws_lambda_function" "my_lambda_function" {
  function_name = module.my_lambda_function_id.resource_id
  role = aws_iam_role.my_iam_role.arn
  filename = "tf-lambda.zip"
  handler = "dist/app.lambdaHandler"
  runtime = "nodejs18.x"
}
resource "aws_cloudwatch_log_group" "my_cloudwatch_log_group" {
  name = "/aws/lambda/${aws_lambda_function.my_lambda_function.id}"
  retention_in_days = 14
}
