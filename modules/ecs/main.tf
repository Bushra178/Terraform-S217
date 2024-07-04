#Create aws ecs cluster
resource "aws_ecs_cluster" "wordpress_cluster" {
  name = var.ecs_cluster_name
  //depends_on = [var.dependency]

   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-cluster"
    }
  )
}

# Create cloudwatch log group
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = var.log_group_name
  retention_in_days = var.log_group_retention
}

#Create Task definition for ecs cluster
resource "aws_ecs_task_definition" "wordpress_task" {
  family                   = var.ecs_family
  //network_mode             = var.ecs_network_mode
  execution_role_arn       = var.ecs_task_role 
  task_role_arn            = var.ecs_task_role 
  runtime_platform {
    operating_system_family = var.ecs_os
    cpu_architecture        = var.ecs_cpu_architecture
  }

  volume {
    name      = var.container_volume
    host_path = var.container_volume_path
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-task-definition"
    }
  )

container_definitions = jsonencode([
  {
    name = var.container_name
    image = var.wordpress_image_name
    memory = var.container_memory
    cpu = var.container_cpu
    portMappings = [
      {
        containerPort = var.container_port
        hostPort = var.host_port
        protocol = var.container_protocol
      }
    ]
    environment = [
      {
        name = "WORDPRESS_DB_HOST"
        value = var.db_address
      },
      {
        name = "WORDPRESS_DB_NAME"
        value = var.db_name
      },
      {
        name = "WORDPRESS_DB_USER"
        value = var.db_user
      },
      {
        name = "WORDPRESS_DB_PASSWORD"
        value = var.db_password
      }
    ]
    logConfiguration = {
      logDriver = var.log_driver
      options = {
        awslogs-group = var.log_group
        awslogs-region = var.logs_region
        awslogs-stream-prefix = var.logs_prefix
      }
    }
  }
])
}

#Create ECS Service
resource "aws_ecs_service" "wordpress_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.wordpress_cluster.id
  task_definition = aws_ecs_task_definition.wordpress_task.arn
  desired_count   = var.service_count

  # network_configuration {
  #   subnets          = var.public_subnet_ids
  #   security_groups  = [var.security_group_id]
  # }

  load_balancer {
    target_group_arn = var.ecs_target_group_arn
    container_name   = var.lb_container_name
    container_port   = var.lb_container_port
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.wordpress_capacity_provider.name
    weight            = var.capacity_provider_weight
    base              = var.capacity_provider_base
  }

   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-ecs-service"
    }
  )
}

# Create ECS Capacity Provider
resource "aws_ecs_capacity_provider" "wordpress_capacity_provider" {
  name = var.ecs_provider_name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.autoscaling_group_arn
    managed_termination_protection = var.termination_protection
    
    managed_scaling {
      maximum_scaling_step_size = var.max_scaling_step_size
      minimum_scaling_step_size = var.min_scaling_step_size
      status                    = var.scaling_status
      target_capacity           = var.target_capacity
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-capacity-provider"
    }
  )
}

resource "aws_ecs_cluster_capacity_providers" "wordpress_cluster_capacity_providers" {
  cluster_name = aws_ecs_cluster.wordpress_cluster.id
  capacity_providers = [aws_ecs_capacity_provider.wordpress_capacity_provider.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.wordpress_capacity_provider.name
    weight            = var.capacity_provider_weight
    base              = var.capacity_provider_base
  }
}


