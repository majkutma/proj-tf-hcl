locals {
  app-root = "frontend"
  base-directory = "dist/proj-terraform"
}
module "my-amplify-app-id" {
  source = "./modules/resource-id"
  branch-name = var.GIT_BRANCH_NAME
  resource-name = "my-amplify-app"
}
resource "aws_amplify_app" "my-amplify-app" {
  name       = module.my-amplify-app-id.resource-id
  repository = var.REPOSITORY_URL
  access_token = var.REPOSITORY_ACCESS_TOKEN
  build_spec = <<-EOT
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
            baseDirectory: ${local.base-directory}
            files:
              - '**/*'
          cache:
            paths:
              - node_modules/**/*
        appRoot: ${local.app-root}
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
    "AMPLIFY_DIFF_DEPLOY": "false",
    "AMPLIFY_MONOREPO_APP_ROOT": local.app-root
  }
}
resource "aws_amplify_branch" "my-amplify-branch" {
  branch_name = var.GIT_BRANCH_NAME
  app_id = aws_amplify_app.my-amplify-app.id
  framework = "Angular"
  stage = "PRODUCTION"
}
