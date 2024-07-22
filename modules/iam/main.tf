# ECS Instance Role
resource "aws_iam_role" "ecs_instance_role" {
  name = "ecsInstanceRole"

  assume_role_policy = data.aws_iam_policy_document.ecs_instance_assume_role_policy.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]
}

data "aws_iam_policy_document" "ecs_instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "ecs_asg_instance_profile" {
  name = "ecsasgInstanceProfile"
  role = aws_iam_role.ecs_instance_role.name
}

# ECS Task Role
resource "aws_iam_role" "ecs_task_role" {
  name = "ecsTaskRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role_policy.json
}

data "aws_iam_policy_document" "ecs_task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_task_policy" {
  statement {
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:AttachNetworkInterface",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DetachNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups"
    ]
    resources = [var.asg_arn]
  }

  statement {
    actions = [
      "rds:DescribeDBInstances",
      "rds:DescribeDBClusters",
      "rds:Connect"
    ]
    resources = [var.db_arn]
  }

  statement {
    actions = ["secretsmanager:GetSecretValue"]
    resources = [var.secret_policy_arn]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [var.s3_bucket_arn]
  }

  statement {
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [var.dynamodb_arn] 
  }
}

resource "aws_iam_policy" "ecs_task_policy" {
  name   = "ecsTaskPolicy"
  policy = data.aws_iam_policy_document.ecs_task_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}

# ECS Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name = "ecsExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_execution_assume_role_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]

  inline_policy {
    name = "ecs_execution_secrets_manager_access"

    policy = data.aws_iam_policy_document.ecs_execution_secrets_manager_access.json
  }
}

data "aws_iam_policy_document" "ecs_execution_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_execution_secrets_manager_access" {
  statement {
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [var.secret_policy_arn]  
  }
}

# ECS Service Role
resource "aws_iam_role" "ecs_service_role" {
  name = "ecsServiceRole"

  assume_role_policy = data.aws_iam_policy_document.ecs_service_assume_role_policy.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]
}

data "aws_iam_policy_document" "ecs_service_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}
