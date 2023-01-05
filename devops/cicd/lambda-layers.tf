module "my_lambda_layer_id" {
  source = "./modules/resource-id"
  branch_name = var.GIT_BRANCH_NAME
  resource_name = "my-lambda-layer"
}
resource "null_resource" "lambda_dependencies" {
  provisioner "local-exec" {
    # command = "cd ../lambda-dist/my-lambda-layer && npm install --production"
      # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash &&\
      # source ~/.bash_profile &&\
      # nvm install v13.6.0 &&\
    # curl https://nodejs.org/dist/latest-v10.x/node-v10.19.0-linux-x64.tar.gz | tar xz --strip-components=1 &&\
    command = <<-EOF
      cd ../lambda-dist/my-lambda-layer &&\
      mkdir ./node_install &&\
      cd ./node_install &&\
      curl https://nodejs.org/dist/v12.16.1/node-v12.16.1.tar.gz | tar xz --strip-components=1 &&\
      export PATH="$PWD/bin:$PATH" &&\
      cd .. &&\
      npm install --production
    EOF
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}
data "null_data_source" "wait_for_lambda_exporter" {
  inputs = {
    lambda_dependency_id = "null_resource.lambda_dependencies.id"
    source_dir           = "../lambda-dist/my-lambda-layer"
  }
}
data "archive_file" "zip-layer" {
  type = "zip"
  source_dir = data.null_data_source.wait_for_lambda_exporter.outputs["source_dir"]
  output_path = "my-lambda-layer.zip"
}
resource "aws_lambda_layer_version" "my_lambda_layer" {
  layer_name = module.my_lambda_layer_id.resource_id
  # filename   = "../lambda-dist/node-modules.zip"
  filename   = "my-lambda-layer.zip"
  compatible_runtimes = ["nodejs18.x"]
}