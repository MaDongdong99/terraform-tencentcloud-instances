output "id" {
  value = tencentcloud_instance.this.id
}

output "instance" {
  value = tencentcloud_instance.this
}

output "public_ip" {
  value = tencentcloud_instance.this.public_ip
}

output "private_ip" {
  value = tencentcloud_instance.this.private_ip
}

output "images" {
  value = module.image.images
}