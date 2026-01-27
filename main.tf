provider "aws" {
  region = "ap-south-1"
}

# --- Security Group (Ports open karne ke liye) ---
resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH and Jenkins"

  # SSH Access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins Access
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outgoing Traffic (Internet access ke liye)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- EC2 Instance ---
resource "aws_instance" "devops_server" {
  # Aapki di hui AMI ID
  ami           = "ami-019715e0d74f695be" 
  
  # Instance Size
  instance_type = "c7i-flex.large"
  
  # Key Pair Name
  key_name      = "amit"

  # Security Group Attach karna
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  # Userdata script link karna
  user_data = file("userdata.sh")

  tags = {
    Name = "DevOps-Server"
  }
}

# --- Output (Result) ---
output "ssh_command" {
  value = "ssh -i amit.pem ubuntu@${aws_instance.devops_server.public_ip}"
}

output "jenkins_url" {
  value = "http://${aws_instance.devops_server.public_ip}:8080"
}