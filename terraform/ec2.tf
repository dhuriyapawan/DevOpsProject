resource "aws_launch_template" "app" {
    name_prefix = "java-app"
    image_id = "ami-0f3caa1cf4417e51b"
    instance_type = "t2.micro"

    user_data = base64decode(file("user-data.sh"))
    vpc_security_group_ids = [aws_security_group.alb_sg.id]

  
}

resource "aws_autoscaling_group" "asg" {
    desired_capacity = 2
    max_size = 3
    min_size = 1

    vpc_zone_identifier = [ aws_subnet.private1.id, aws_subnet.private2.id ]
  

  launch_template {
    id = aws_launch_template.app.id
    version = "$latest"
  }
  target_group_arns = [aws_lb_target_group.app_tg.arn]
}