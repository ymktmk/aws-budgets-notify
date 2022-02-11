resource "aws_iam_role" "iam_for_lambda" {
    name = "aws-budgets-notify"
    assume_role_policy = <<EOF
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
EOF
}

resource "aws_lambda_function" "lambda_function" {
    # filenameが必要 s3から取得する
    filename      = "function.zip"
    function_name = "aws-budgets-notify"
    role          = aws_iam_role.iam_for_lambda.arn
    architectures                  = ["x86_64"]
    handler                        = "main"
    memory_size                    = 512
    package_type                   = "Zip"
    runtime                        = "go1.x"
    timeout                        = 15
    # 環境変数
    # environment {
    #     variables = {

    #     }
    # }
}