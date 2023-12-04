resource "aws_instance" "web" {
  ami                    = var.aws_ami
  instance_type          = var.aws_instance_type
  vpc_security_group_ids = [var.ec2_security_group_id] # Adicione grupos de segurança, se necessário
  subnet_id              = var.subnet_id               # Substitua pelo ID da sua sub-rede
  tags                   = var.instance_tags
}

resource "aws_launch_configuration" "my_launch_config" {
  name = "my-launch-config"

  image_id        = var.aws_ami
  instance_type   = var.aws_instance_type
  security_groups = var.security_groups // Substitua my_sg pelo seu security group

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "lt" {
  name_prefix            = "my-launch-template"
  image_id               = var.aws_ami
  instance_type          = var.aws_instance_type
  vpc_security_group_ids = var.security_groups

  user_data = base64encode(templatefile("${path.module}/user_data.tftpl", {
    rds_host = var.rds_host
  }))

}

resource "aws_autoscaling_group" "my_asg" { //asg = auto scaling group
  desired_capacity    = 2                   // Número desejado de instâncias
  max_size            = 5                   // Número máximo de instâncias
  min_size            = 1                   // Número mínimo de instâncias
  health_check_type   = "EC2"
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "MyASGInstance"
    propagate_at_launch = true
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "scale-up-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300" // Período de verificação em segundos
  statistic           = "Average"
  threshold           = "70" // Limiar para acionar a política de escala para cima
  alarm_description   = "Scale up when CPU exceeds 70% for 10 minutes"
  alarm_actions       = [aws_autoscaling_policy.scale_up_policy.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg.name
  }

}

resource "aws_autoscaling_policy" "scale_up_policy" {
  name               = "scale-up-policy"
  scaling_adjustment = 1  // Ajuste de escala para cima
  cooldown           = 10 // Período de cooldown em segundos
  adjustment_type    = "ChangeInCapacity"

  // Substitua "your_autoscaling_group_name" pelo nome do seu grupo de Auto Scaling
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
}

resource "aws_autoscaling_policy" "scale_down_policy" {
  policy_type               = "TargetTrackingScaling"
  name                      = "scale-down-policy"
  estimated_instance_warmup = 300 // Período de aquecimento estimado
  autoscaling_group_name    = aws_autoscaling_group.my_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 20 // Limiar para acionar a política de escala para baixo
  }

  lifecycle {
    create_before_destroy = true
  }
}