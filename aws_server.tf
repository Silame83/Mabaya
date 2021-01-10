resource "aws_key_pair" "ohio_kp" {
  key_name = "ohio-qa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQsiQzUYBjED7WvyqK6rMUSI2DDz8Xuhjb+KjW1GVQBazLpK9ynj/YRK2bsFkDMmUEjg1hcfPlbzx+oOpShnzUPRxY/iEFguFdnxEw9NN02dBdMnPEpQPylljnC1xtPSFko60RivpeCpvngkTZtc+crqF8CDwYGm+hYo6Y8YRtFvcDQ/re1zEld7CTxueoMHIqCno6mPw+kMcYtWiHV8GjwCl5Fl+u+yX5y1mbHhJPopg3yeYX0ZZppxPRa8AQYoHSZ0OPjIiAOj5e4lL0NB6bdDwY+yw8T3IosD3AZwl4FzuBKiPlStPBeE+tAimZZl0sZI97cr58aDHdsVThEx7j qa"
}

//----------------------------------Echo service app server-------------------------------------

resource "aws_instance" "echo_server" {
  ami = "ami-0a91cd140a1fc148a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.sg_mabaya.id]
  subnet_id = aws_subnet.mabaya_subnet.id
  key_name = aws_key_pair.ohio_kp.id
  user_data = file("userdata.sh")
  tags = {
    Name = "Echo service App"
  }
}

resource "aws_eip_association" "ec2_eip" {
  instance_id = aws_instance.echo_server.id
  allocation_id = aws_eip.ec2_ip.id
  depends_on = [
    aws_instance.echo_server]
}