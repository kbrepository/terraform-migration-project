resource "aws_launch_template" "this" {
  name_prefix   = "launch-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd

    cat <<EOF > /var/www/html/index.html
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Terraform ALB + EC2</title>
      <style>
        body {
          background-color: #f4f4f4;
          font-family: Arial, sans-serif;
          text-align: center;
          padding-top: 100px;
        }
        .box {
          background: white;
          display: inline-block;
          padding: 30px;
          border-radius: 10px;
          box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }
        h1 {
          color: #2c3e50;
        }
        p {
          font-size: 18px;
          color: #555;
        }
      </style>
    </head>
    <body>
      <div class="box">
        <h1>Hello from Terraform EC2 Behind ALB 🎉</h1>
        <p>This page is served from an EC2 instance created via Terraform and connected through an Application Load Balancer.</p>
      </div>
    </body>
    </html>
    EOF

  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.this.id]
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ec2-instance"
    }
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity     = var.asg_desired_capacity
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  vpc_zone_identifier  = var.subnet_ids
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "autoscaling-ec2"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "this" {
  name        = "ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_autoscaling_attachment" "this" {
  depends_on = [aws_autoscaling_group.this]

  autoscaling_group_name = aws_autoscaling_group.this.name
  lb_target_group_arn    = var.alb_target_group_arn != null ? var.alb_target_group_arn : "skip"
}

