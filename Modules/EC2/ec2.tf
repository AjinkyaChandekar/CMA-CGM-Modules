resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.i_type


  tags = {
    Name = "HelloWorld"
  }
}
