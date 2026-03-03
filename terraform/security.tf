resource "aws_security_group" "alb_sg" {
    vpc_id = module.vpc.vpc_id
    ingress {
        from_port =  80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }  
}

resource "aws_security_group" "app_sg" {
            vpc_id = module.vpc.vpc_id
            
            ingress  {
                from_port = 8080
                to_port = 8080
                protocol = "tcp"
                security_groups = [aws_security_group.alb_sg.id]
            }

  
}