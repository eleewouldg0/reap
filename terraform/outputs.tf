output "bucket_name" {
  value = aws_s3_bucket.demo_bucket.bucket
}

output "instance_id" {
  value = aws_instance.demo_instance.id
}

output "security_group_id" {
  value = aws_security_group.demo_sg.id
}
