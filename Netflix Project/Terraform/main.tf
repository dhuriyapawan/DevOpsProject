locals {
  instance_names = [
    "jenkins-server",
    "monitoring-server",
    "kubernetes-master-node",
    "kubernetes-worker-node"
  ]
}
resource "aws_instance" "ec2" {
  count                  = var.ec2_instance_count
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = aws_subnet.public_subnet[count.index].id
  instance_type          = var.ec2_instance_type[count.index]
  iam_instance_profile   = aws_iam_instance_profile.iam_instance_profile.name
  vpc_security_group_ids = [aws_security_group.default_ec2_sg.id]

  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = var.ec2_volume_type
  }

  tags = {
    Name = "ec2-${count.index + 1}"
    Env  = var.environment
  }
}

resource "aws_ebs_volume" "ec2_volume" {
  count             = var.ec2_instance_count
  size              = var.ec2_volume_size
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${local.org}-${local.project}-${local.env}-${local.instance_names[count.index]}"
    Env  = local.env
  }
}