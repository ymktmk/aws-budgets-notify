# IAMロール（Lambda）
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

# lambda関数
resource "aws_lambda_function" "lambda_function" {
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
    #         foo = "bar"
    #     }
    # }
    depends_on = [
        aws_iam_role_policy_attachment.lambda_logs,
        aws_cloudwatch_log_group.log_group,
    ]
}

resource "aws_cloudwatch_log_group" "log_group" {
    name              = "/aws/lambda/aws-budgets-notify"
    # retention_in_days = 14
}

# IAMポリシー
resource "aws_iam_policy" "lambda_logging" {
    name        = "lambda_logging"
    path        = "/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*",
        "Effect": "Allow"
        }
    ]
}
EOF
}

# IAMロールにIAMポリシーをアタッチする
resource "aws_iam_role_policy_attachment" "lambda_logs" {
    role       = aws_iam_role.iam_for_lambda.name
    policy_arn = aws_iam_policy.lambda_logging.arn
}

# トリガー
resource "aws_lambda_permission" "with_sns" {
    statement_id  = "AllowExecutionFromSNS"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda_function.function_name
    principal     = "sns.amazonaws.com"
    source_arn    = aws_sns_topic.topic.arn
}