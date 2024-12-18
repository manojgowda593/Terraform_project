output "Instance_Public_IP" {
    value = aws_instance.My_EC2_Instance.public_ip
}

output "Instance_Public_key" {
    value= aws_instance.My_EC2_Instance.key_name
}