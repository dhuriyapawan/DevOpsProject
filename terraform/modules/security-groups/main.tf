# main.tf

# ---

# `modules/security-groups/main.tf`

# ```hcl
############################################
# EKS CLUSTER SECURITY GROUP
############################################

resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.environment}-eks-cluster-sg"
  description = "EKS Cluster Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
  }
}

############################################
# NODE GROUP SECURITY GROUP
############################################

resource "aws_security_group" "node_group_sg" {
  name        = "${var.environment}-node-group-sg"
  description = "EKS Node Group Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "Node to Node"

    from_port = 0
    to_port   = 65535
    protocol  = "tcp"

    self = true
  }

  ingress {
    description = "Cluster Communication"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    security_groups = [
      aws_security_group.eks_cluster_sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
  }
}