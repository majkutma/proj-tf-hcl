module "my-iam-role-id" {
  source = "./modules/resource-id"
  branch-name = var.GIT_BRANCH_NAME
  resource-name = "my-iam-role"
}
resource "aws_iam_role" "my-iam-role" {
  name = module.my-iam-role-id.resource-id
  assume_role_policy = <<EOT
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
  EOT
}
