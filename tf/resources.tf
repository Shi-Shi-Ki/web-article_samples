# SNS
resource "aws_sns_topic" "test-sns" {
  name = "test-sns"
}
output "test-sns-arn" {
  value = aws_sns_topic.test-sns.arn
}
# SQS
resource "aws_sqs_queue" "test-sqs" {
  name = "test-sqs"
}

resource "aws_sns_topic_subscription" "test" {
  topic_arn = aws_sns_topic.test-sns.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.test-sqs.arn
}

resource "aws_iam_role" "lambda_sqs" {
  name                 = "lambda_sqs"
  max_session_duration = 3600
  description          = "None"
  assume_role_policy   = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sqs:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        }
    ]
}
EOF
}

# Lambda
data "archive_file" "example_zip" {
  type        = "zip"
  source_dir  = "${path.cwd}/../lambda_ts/dist"
  output_path = "${path.cwd}/../lambda_ts/dist/index.zip"
}

resource "aws_lambda_function" "test-lambda" {
  function_name = "test-lambda"
  description   = "Test Lambda"
  role          = aws_iam_role.lambda_sqs.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  timeout       = 3
  filename      = data.archive_file.example_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.example_zip.output_path)
}

resource "aws_lambda_event_source_mapping" "test-lambda-trigger" {
  event_source_arn = aws_sqs_queue.test-sqs.arn
  function_name    = "test-lambda"
  batch_size       = 10
}
