resource "aws_ecs_cluster" "wordpress_cluster" {
  name = "wordpress-cluster"

  tags = {
    Name = "${var.env_prefix}-ecs-cluster"
  }
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/wordpress"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "wordpress_task" {
  family                   = "wordpress"
  network_mode             = "awsvpc"
  execution_role_arn       = var.ecs_task_role # Attach execution role if needed
  task_role_arn            = var.ecs_task_role # Attach task role if needed

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  tags = {
    Name = "${var.env_prefix}-task"
  }

  container_definitions = <<EOF
[
  {
    "name": "wordpress",
    "image": "${var.wordpress_image_name}",
    "memory": 512,
    "cpu": 512,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "WORDPRESS_DB_HOST",
        "value": "${var.db_address}"
      },
      {
        "name": "WORDPRESS_DB_NAME",
        "value": "${var.db_name}"
      },
      {
        "name": "WORDPRESS_DB_USER",
        "value": "${var.db_user}"
      },
      {
        "name": "WORDPRESS_DB_PASSWORD",
        "value": "${var.db_password}"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/wordpress",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
EOF
}


resource "aws_ecs_service" "wordpress_service" {
  name            = "wordpress-service"
  cluster         = aws_ecs_cluster.wordpress_cluster.id
  task_definition = aws_ecs_task_definition.wordpress_task.arn
  desired_count   = 2

  network_configuration {
    subnets          = var.public_subnet_ids
    security_groups  = var.security_group_id
  }

  load_balancer {
    target_group_arn = var.ecs_target_group_arn
    container_name   = "wordpress"
    container_port   = 80
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.wordpress_capacity_provider.name
    weight            = 1
    base              = 1
  }

  tags = {
    Name = "${var.env_prefix}-service"
  }
}

# Create ECS Capacity Provider
resource "aws_ecs_capacity_provider" "wordpress_capacity_provider" {
  name = "wordpress-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.autoscaling_group_arn
    managed_termination_protection = "ENABLED"
    
    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 75
    }
  }

  tags = {
    Name = "${var.env_prefix}-capacity-provider"
  }
}

resource "aws_ecs_cluster_capacity_providers" "wordpress_cluster_capacity_providers" {
  cluster_name = aws_ecs_cluster.wordpress_cluster.id
  capacity_providers = [aws_ecs_capacity_provider.wordpress_capacity_provider.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.wordpress_capacity_provider.name
    weight            = 1
    base              = 1
  }
}


