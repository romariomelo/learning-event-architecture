resource "aws_sns_topic" "example_sns_topic" {
  name                        = "example-sns-topic.fifo"
  fifo_topic                  = true
  content_based_deduplication = true
}

resource "aws_sns_topic_subscription" "example_sns_topic_subscription" {
  topic_arn = aws_sns_topic.example_sns_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.example_queue.arn
}
