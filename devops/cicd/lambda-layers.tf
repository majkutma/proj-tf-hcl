module "my_lambda_layer_id" {
  source        = "./modules/resource-id"
  branch_name   = var.GIT_BRANCH_NAME
  resource_name = "my-lambda-layer"
}
resource "null_resource" "lambda_dependencies" {
  provisioner "local-exec" {
    command = <<-EOF
      cd ../lambda-dist/my-lambda-layer &&\
      mkdir ./node_install &&\
      cd ./node_install &&\
      curl https://nodejs.org/dist/v18.12.1/node-v18.12.1-linux-x64.tar.gz | tar xz --strip-components=1 &&\
      export PATH="$PWD/bin:$PATH" &&\
      cd .. &&\
      npm install --omit=dev
    EOF
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}
data "archive_file" "zip_layer" {
  depends_on  = [null_resource.lambda_dependencies]
  type        = "zip"
  source_dir  = "../lambda-dist/my-lambda-layer"
  output_path = "my-lambda-layer.zip"
}
resource "aws_lambda_layer_version" "my_lambda_layer" {
  depends_on          = [data.archive_file.zip_layer]
  layer_name          = module.my_lambda_layer_id.resource_id
  filename            = "my-lambda-layer.zip"
  compatible_runtimes = ["nodejs18.x"]
}