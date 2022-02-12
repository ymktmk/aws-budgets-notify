# aws-budgets-notify

・AWS Budgetsにて予算を決定し、閾値を超えるとSNSへ
・SNSからLambdaへ
・Lambdaはの言語はGo
・ログはCloudWatchに転送設定していない

```
$ cd terraform

$ sh build.sh

$ terraform apply
```

# 参考文献

https://dev.classmethod.jp/articles/show-your-aws-billing-info-to-iam-users/

https://dev.classmethod.jp/articles/aws-budgets-line/
