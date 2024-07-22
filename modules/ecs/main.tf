# ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-cluster"
    }
  ) 
}

# ECS Task Definition
resource "aws_ecs_task_definition" "wordpress_task" {
  family                   = var.task_family
  network_mode             = var.network_mode
  task_role_arn            = var.ecs_task_role
  execution_role_arn       = var.task_execution_role

  volume {
    name = "efs-volume"

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.wordpress_efs.id
      root_directory          = "/opt/data"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2999
    }
  }

  container_definitions    = jsonencode([
    {
      name      = var.container_name,
      image     = var.container_image,
      memory    = var.container_memory,
      cpu       = var.container_cpu,
      essential = var.container_essentials

      portMappings = [
        {
          containerPort = var.container_port,
          hostPort      = var.container_host_port,
          protocol = var.container_protocol
        }
      ],

      mountPoints = [
        {
          sourceVolume  = "efs-volume"
          containerPath = "/mnt/efs"
        }
      ]

      "environment": [
        {
          "name": "WORDPRESS_DB_HOST",
          "value": var.db_endpoint
        },
        {
          "name": "WORDPRESS_DB_NAME",
          "value": var.db_name
        },
        {
          "name": "WORDPRESS_DB_USER",
          "value": var.db_user
        },
      ],
      
        secrets = [
        {
          name      = "WORDPRESS_DB_PASSWORD"
          valueFrom = var.secret_policy_arn
        }
        ]

      logConfiguration = {
      logDriver = var.log_driver
      options = {
        awslogs-group = var.log_group_name
        awslogs-region = var.logs_region
        awslogs-stream-prefix = var.logs_stream_prefix
      }
    }
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "wordpress_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.wordpress_task.arn
  //iam_role        = var.ecs_service_role
  desired_count   = var.service_desired_count
  launch_type     = var.service_launch_type

  network_configuration {
    subnets          = var.private_subnet_ids 
    security_groups  = [var.sg_id]
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

# Create EFS file system
resource "aws_efs_file_system" "wordpress_efs" {
  performance_mode = "generalPurpose"  
  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-cluster"
    }
  ) 
}

# Create an EFS Mount Target
resource "aws_efs_mount_target" "example" {
  for_each = toset(var.private_subnet_ids) 

  file_system_id = aws_efs_file_system.wordpress_efs.id
  subnet_id      = each.value
  security_groups = [var.sg_id]
}



