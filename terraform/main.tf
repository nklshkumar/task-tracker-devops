resource "aws_security_group" "task_tracker_sg" {
  name = "task-tracker-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "task_tracker_ec2" {
  ami           = "ami-03bb6d83c60fc5f7c"
  instance_type = var.instance_type

  key_name = var.key_name

  security_groups = [
    aws_security_group.task_tracker_sg.name
  ]

  tags = {
    name = "task_tracker_ec2"
  }
}

resource "aws_s3_bucket" "task_tracker_bucket" {
  bucket = "task-tracker-${random_id.bucket_id.hex}"
}

resource "random_id" "bucket_id" {
  byte_length = 4
}
