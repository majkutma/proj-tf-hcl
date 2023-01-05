module "my-iam-role-id" {
  source = "./modules/resource-id"
  branch-name = var.GIT_BRANCH_NAME
  resource-name = "my-iam-role"
}
data "aws_iam_policy" "aws-lambda-basic-execution-role" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
resource "aws_iam_role" "my-iam-role" {
  name = module.my-iam-role-id.resource-id
  assume_role_policy = data.aws_iam_policy.aws-lambda-basic-execution-role.policy
}
