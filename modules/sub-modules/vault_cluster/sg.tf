resource "aws_security_group" "vault" {
  name        = "vault-sg-${var.region}-${var.random_id}"
  description = "SG for Vault SSH and Vault traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "vault-${var.region}-${var.random_id}"
  }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Vault Client Traffic
  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Leaving traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}