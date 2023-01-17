module "my_iam_role_id" {
  source        = "./modules/resource-id"
  branch_name   = var.GIT_BRANCH_NAME
  resource_name = "my-iam-role"
}
data "aws_iam_policy_document" "aws_lambda_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "my_iam_role" {
  name               = module.my_iam_role_id.resource_id
  assume_role_policy = data.aws_iam_policy_document.aws_lambda_trust_policy.json
}
resource "aws_iam_role_policy_attachment" "my_attachment" {
  role       = aws_iam_role.my_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
