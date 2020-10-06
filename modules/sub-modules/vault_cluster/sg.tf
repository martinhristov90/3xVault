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

  # All TCP connections are allowed if they are located in the same SG
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  # All ICMP connections are allowed if they are located in the same SG
  ingress {
    from_port = 0
    to_port   = 254
    protocol  = "icmp"
    self      = true
  }

  # Leaving traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}