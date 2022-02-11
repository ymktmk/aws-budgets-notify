resource "aws_budgets_budget" "cost1" {
    budget_type  = "COST"
    limit_amount = "10.0"
    limit_unit   = "USD"
    name         = "月$10予算"
    time_unit    = "MONTHLY"
    notification {
        comparison_operator        = "GREATER_THAN"
        notification_type          = "ACTUAL"
        subscriber_email_addresses = ["ymktmk.co@gmail.com"]
        subscriber_sns_topic_arns  = [aws_sns_topic.topic.arn]
        threshold                  = 80
        threshold_type             = "PERCENTAGE"
    }
}

resource "aws_budgets_budget" "cost2" {
    budget_type  = "COST"
    limit_amount = "5.0"
    limit_unit   = "USD"
    name         = "月$5予算"
    time_unit    = "MONTHLY"
    notification {
        comparison_operator        = "GREATER_THAN"
        notification_type          = "ACTUAL"
        subscriber_email_addresses = ["ymktmk.co@gmail.com"]
        subscriber_sns_topic_arns  = [aws_sns_topic.topic.arn]
        threshold                  = 80
        threshold_type             = "PERCENTAGE"
    }
}