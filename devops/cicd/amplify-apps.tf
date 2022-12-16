module "my-amplify-app-id" {
  source = "./modules/resource-id"
  branch-name = var.git-branch-name
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
            baseDirectory: dist/app
            files:
              - '**/*'
          cache:
            paths:
              - node_modules/**/*
        appRoot: ${var.REPOSITORY_FOLDER_PATH}
  EOT

  environment_variables = {
    "AMPLIFY_DIFF_DEPLOY": "true",
    "AMPLIFY_MONOREPO_APP_ROOT": "frontend"
  }
}
resource "aws_amplify_branch" "my-amplify-branch" {
  branch_name = var.git-branch-name
  app_id = aws_amplify_app.my-amplify-app.id
}