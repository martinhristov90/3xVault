resource "aws_security_group" "vault" {
  name        = "vault-sg-${var.region}-${var.random_id}"
  description = "SG for Vault SSH and Vault traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "vault-${var.region}-${var.random_id}"
  }

  # SSH
  # tfsec:ignore:aws-vpc-no-public-ingress-sgr
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allowing SSH traffic from anywhere"
  }

  # Vault Client Traffic
  # tfsec:ignore:aws-vpc-no-public-ingress-sgr
  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allowing Vault API traffic from anywhere"
  }

  # Vault cluster (node-to-node) traffic
  # tfsec:ignore:aws-vpc-no-public-ingress-sgr
  ingress {
    from_port   = 8201
    to_port     = 8201
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allowing Vault cluster traffic from anywhere"
  }


  # All TCP connections are allowed if they are located in the same SG
  # tfsec:ignore:aws-vpc-no-public-ingress-sgr
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
    description = "Allowing connections withing the same SG"
  }

  # All ICMP connections are allowed if they are located in the same SG
  ingress {
    from_port   = 0
    to_port     = 254
    protocol    = "icmp"
    self        = true
    description = "Allowing ICMP traffic within the same SG"
  }

  # Leaving traffic
  # tfsec:ignore:aws-vpc-no-public-egress-sgr
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allowing egress traffic to anywhere"
  }
}