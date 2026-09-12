# ASG Module

resource "aws_launch_template" "main" {
  name_prefix   = "${var.environment}-lt"
  image_id      = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.security_group_ids

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    harbor_registry = var.harbor_registry
    harbor_username = var.harbor_username
    harbor_password = var.harbor_password
    harbor_insecure = var.harbor_insecure
    image_ref       = "${var.harbor_registry}/${var.harbor_project}/${var.harbor_image}:${var.harbor_image_tag}"
    db_endpoint     = var.db_endpoint
    db_name         = var.db_name
    db_username     = var.db_username
    db_password     = var.db_password
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.environment}-web-instance"
      Environment = var.environment
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  name                = "${var.environment}-asg"
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = var.target_group_arns
  health_check_type   = "ELB"
  health_check_grace_period = 300

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-web-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}
