# # Create ECS Instance Role
# resource "aws_iam_role" "ecs_instance_role" {
#   name = "ecs_instance_role"
  
#   assume_role_policy = data.aws_iam_policy_document.ecs_instance_assume_role_policy.json
# }

# # ECS Instance Role Assume Role Policy Document
# data "aws_iam_policy_document" "ecs_instance_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }

#     effect = "Allow"
#   }
# }

# # Attach Managed Policy to ECS Instance Role
# resource "aws_iam_policy_attachment" "ecs_instance_role_policy" {
#   name       = "ecs_instance_role_policy"
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
#   roles      = [aws_iam_role.ecs_instance_role.name]
# }

# # Create IAM Instance Profile for ECS
# resource "aws_iam_instance_profile" "ecs_instance_profile" {
#   name = "ecs_instance_profile"
#   role = aws_iam_role.ecs_instance_role.name
# }

# # Create ECS Task Role
# resource "aws_iam_role" "ecs_task_role" {
#   name = "ecs_task_role_for_wordpress"
  
#   assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role_policy.json
# }

# # ECS Task Role Assume Role Policy Document
# data "aws_iam_policy_document" "ecs_task_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }

#     effect = "Allow"
#   }
# }

# # ECS Task Policy Document
# data "aws_iam_policy_document" "ecs_task_policy" {
#   statement {
#     actions = [
#       "rds-db:connect"
#     ]
#     resources = ["*"]
#     effect    = "Allow"
#   }

#   statement {
#     actions = [
#       "ecs:ListClusters",
#       "ecs:DescribeClusters",
#       "ecs:RegisterTaskDefinition",
#       "ecs:DescribeTaskDefinition",
#       "ecs:UpdateService",
#       "ecs:DescribeServices",
#       "ecs:ListServices"
#     ]
#     resources = ["*"]
#     effect    = "Allow"
#   }

#   statement {
#     actions = [
#       "logs:CreateLogStream",
#       "logs:PutLogEvents"
#     ]
#     resources = ["*"]
#     effect    = "Allow"
#   }

#   statement {
#     actions = [
#       "ec2:DescribeNetworkInterfaces",
#       "ec2:DetachNetworkInterface",
#       "ec2:AttachNetworkInterface"
#     ]
#     resources = ["*"]
#     effect    = "Allow"
#   }
# }

# # Create ECS Task Policy
# resource "aws_iam_policy" "ecs_task_policy" {
#   name        = "ecs_task_policy_for_wordpress"
#   description = "IAM policy for ECS tasks to access necessary resources"

#   policy = data.aws_iam_policy_document.ecs_task_policy.json
# }

# # Attach ECS Task Policy to ECS Task Role
# resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
#   role       = aws_iam_role.ecs_task_role.name
#   policy_arn = aws_iam_policy.ecs_task_policy.arn
# }




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

# Create IAM Policy attachment 
resource "aws_iam_policy_attachment" "ecs_instance_role_policy" {
    name = "ecs_instance_role_policy"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
    roles = [aws_iam_role.ecs_instance_role.name]
}


# Create IAM instance profile
resource "aws_iam_instance_profile" "ecs_instance_profile" {
    name = "ecs_instance_profile"
    role = aws_iam_role.ecs_instance_role.name
}

#Create Role for ECS Cluster
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
      },

      {
        Action   = "ecs:*",
        Effect   = "Allow",
        Resource = "*"
      },
      
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeNetworkInterfaces",
          "ec2:DetachNetworkInterface",
          "ec2:AttachNetworkInterface"
        ],
        "Resource": "*"
      }
    ]
  })
}

# Attach IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}

