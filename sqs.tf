resource "aws_sqs_queue" "example_queue" {
  name                        = "example-queue.fifo"
  visibility_timeout_seconds  = 30
  fifo_queue                  = true
  content_based_deduplication = true
}

data "aws_iam_policy_document" "example_policy" {
  statement {
    sid    = "Sid_Default"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["sqs:*"]
    resources = [aws_sqs_queue.example_queue.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.example_sns_topic.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "example_queue_policy" {
  queue_url = aws_sqs_queue.example_queue.id
  policy    = data.aws_iam_policy_document.example_policy.json
}
