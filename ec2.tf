# Find the latest Amazon Linux 2023 image instead of hardcoding an AMI ID,
# since AMI IDs differ by region and change over time
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# Use the default VPC so we don't build networking yet (that's Week 2)
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# A firewall with no inbound rules: nothing can connect in,
# but the instance can reach out (for updates, for example)
resource "aws_security_group" "learning" {
  name        = "learning-ec2-sg"
  description = "No inbound traffic, outbound allowed"
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_instance" "learning" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.learning.id]

  # Require IMDSv2 (session-token-based metadata access).
  # This blocks a common class of credential-theft attacks.
  metadata_options {
    http_tokens = "required"
  }

  tags = merge(local.common_tags, { Name = "learning-ec2" })
}