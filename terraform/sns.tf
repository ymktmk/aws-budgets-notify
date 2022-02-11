# トピック
resource aws_sns_topic topic {
    name = "aws-budgets-notify"
}

# トピックポリシー
resource "aws_sns_topic_policy" "topic_policy" {
    arn = aws_sns_topic.topic.arn
    policy = jsonencode(
        {
            Id        = "__default_policy_ID"
            Statement = [
                {
                    Action    = "SNS:Publish"
                    Effect    = "Allow"
                    Principal = {
                        Service = "budgets.amazonaws.com"
                    }
                    Resource  = aws_sns_topic.topic.arn
                    Sid       = "AWSBudgetsSNSPublishingPermissions"
                }
            ]
        }
    )
}

# サブスクリプション
resource "aws_sns_topic_subscription" "topic_subscription" {
    topic_arn = aws_sns_topic.topic.arn
    protocol  = "lambda"
    endpoint  = aws_lambda_function.lambda_function.arn
}
