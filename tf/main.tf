provider "aws" {
    region = "us-east-1"
    access_key = "dummy"
    secret_key = "dummy"

    skip_requesting_account_id = true
    skip_credentials_validation = true

    endpoints {
        lambda = "http://localhost:4566"
        sns = "http://localhost:4566"
        sqs = "http://localhost:4566"
        iam = "http://localhost:4566"
    }
}