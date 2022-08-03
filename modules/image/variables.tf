variable "os_name" {
  description = "A string to apply with fuzzy match to the os_name attribute on the image list returned by TencentCloud."
  type        = string
  default = ""
}

variable "image_name" {
  type = string
  default = ""
}

variable "image_type" {
  type = list(string)
  default = ["PUBLIC_IMAGE"]
}

variable "image_id" {
  type = string
  default = ""
}