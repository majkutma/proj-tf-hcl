locals {
  app_root       = "frontend"
  base_directory = "dist/proj-terraform"
}
module "my_amplify_app_id" {
  source        = "./modules/resource-id"
  branch_name   = var.GIT_BRANCH_NAME
  resource_name = "my-amplify-app"
}
resource "aws_amplify_app" "my_amplify_app" {
  name         = module.my_amplify_app_id.resource_id
  repository   = var.REPOSITORY_URL
  access_token = var.REPOSITORY_ACCESS_TOKEN
  build_spec   = <<EOT
    version: 1
    applications:
      - frontend:
          phases:
            preBuild:
              commands:
                - npm ci
            build:
              commands:
                - npm run build
          artifacts:
            baseDirectory: ${local.base_directory}
            files:
              - '**/*'
          cache:
            paths:
              - node_modules/**/*
        appRoot: ${local.app_root}
  EOT

  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }
  custom_rule {
    source = "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>"
    status = "200"
    target = "/index.html"
  }

  environment_variables = {
    "AMPLIFY_DIFF_DEPLOY" : "false",
    "AMPLIFY_MONOREPO_APP_ROOT" : local.app_root
  }
}
resource "aws_amplify_branch" "my_amplify_branch" {
  branch_name = var.GIT_BRANCH_NAME
  app_id      = aws_amplify_app.my_amplify_app.id
  framework   = "Angular"
  stage       = "PRODUCTION"
}
