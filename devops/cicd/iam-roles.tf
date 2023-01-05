module "my-iam-role-id" {
  source = "./modules/resource-id"
  branch-name = var.GIT_BRANCH_NAME
  resource-name = "my-iam-role"
}
data "aws_iam_policy_document" "aws-lambda-trust-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "my-iam-role" {
  name = module.my-iam-role-id.resource-id
  assume_role_policy = data.aws_iam_policy_document.aws-lambda-trust-policy.policy
}
resource "aws_iam_role_policy_attachment" "my-attachment" {
  role       = "${aws_iam_role.terraform_function_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
