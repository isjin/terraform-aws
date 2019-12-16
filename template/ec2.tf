#eips
resource "aws_eip" "nat_gateways_eip" {
  count = length(var.nat_gateways_tags)
  vpc      = true
  tags = {
    "Name" = var.eip_nat_gateways_tags[count.index]
  }
}

#keypairs
resource "aws_key_pair" "bastion" {
  key_name   = "bastion"
  public_key = file("files/id_rsa.pub")
}

#ec2
resource "aws_instance" "bastion" {
  ami = "ami-0f62e91915e16cfc2"
  instance_type = "t2.micro"
  availability_zone = var.availible_zone[0]
  key_name = aws_key_pair.bastion.key_name
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id = aws_subnet.public_subnets.*.id[0]
  iam_instance_profile = aws_iam_instance_profile.jtp_profile.name
  associate_public_ip_address = true
  user_data = file("files/bastion_userdata.sh")
  root_block_device {
    volume_size = 10
  }
  ebs_block_device {
  device_name ="/dev/sdb"
  volume_size =10
  }
  tags = {
    "Name" = "bastion"
  }
  volume_tags = {
    "Name" = "bastion"
  }
  depends_on = [aws_key_pair.bastion,aws_iam_role.jtp_role,aws_security_group.bastion,aws_subnet.public_subnets]
  provisioner "file" {
    source      = "files/docker/app.py"
    destination = "/tmp/app.py"
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("files/id_rsa")
      host     = aws_instance.bastion.public_ip
    }
  }
  provisioner "file" {
    source      = "files/docker/Dockerfile"
    destination = "/tmp/Dockerfile"
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("files/id_rsa")
      host     = aws_instance.bastion.public_ip
    }
  }
  provisioner "file" {
    source      = "files/docker/requirements.txt"
    destination = "/tmp/requirements.txt"
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("files/id_rsa")
      host     = aws_instance.bastion.public_ip
    }
  }
  provisioner "file" {
    source      = "files/bastion_build.sh"
    destination = "/tmp/bastion_build.sh"
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("files/id_rsa")
      host     = aws_instance.bastion.public_ip
    }
  }
}


