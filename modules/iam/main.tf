resource "aws_iam_role" "ecs_instance_role" {
  name = "ecs_instance_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "ecs_instance_role_policy" {
    name = "ecs_instance_role_policy"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
    roles = [aws_iam_role.ecs_instance_role.name]
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
    name = "ecs_instance_profile"
    role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role_for_wordpress"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# IAM policy granting permissions to interact with RDS
resource "aws_iam_policy" "ecs_task_policy" {
  name = "ecs_task_policy_for_wordpress"
  description = "IAM policy for ECS tasks to access RDS"
  
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "rds-db:connect"
        ],
        "Resource": "*"
      }
      # Add additional permissions as needed, e.g., for other AWS services or resources
    ]
  })
}

# Attach IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}

