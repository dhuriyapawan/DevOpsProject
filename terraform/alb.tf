resource "aws_lb" "app_alb" {
    load_balancer_type =  "application"
    subnets = [aws_subnet.public1.id, aws_subnet.public2.id]
    security_groups = [aws_security_group.alb_sg.id]
  
}

resource "aws_lb_target_group" "app_tg" {
  port =8080
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
}

resource "aws_lb_listener" "listener" {
     load_balancer_arn =  aws_lb.app_alb.arn
     port = 80
     protocol = "HTTP"
     default_action {
       type = "forward"
       target_group_arn =  aws_lb_target_group.app_tg.arn
     }
}