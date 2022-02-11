# Lambdaを実行するためのIAM Role

resource "aws_iam_policy" "default" {
    name        = aws_lambda_function.function_name
    policy      = [

    ]
}

resource "aws_iam_role_policy_attachment" "default" {
    role       = aws_iam_role.default.name
    policy_arn = aws_iam_policy.default.arn
}
