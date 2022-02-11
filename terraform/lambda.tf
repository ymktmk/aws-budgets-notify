resource "aws_lambda_function" "lambda_function" {
    architectures                  = ["x86_64"]
    handler                        = "main"
    memory_size                    = 512
    package_type                   = "Zip"
    runtime                        = "go1.x"
    timeout                        = 15
    # 環境変数
    environment {
        variables = {

        }
    }
}