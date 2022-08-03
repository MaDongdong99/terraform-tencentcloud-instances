variable "name" {
  description = "Name of the ENI."
  type        = string
  default     = "未命名"
}

variable "vpc_id" {
  description = "Id of the vpc at which the ENI locates."
  type        = string
}

variable "subnet_id" {
  description = "Id of the subnet at which the ENI locates."
  type        = string
}

variable "attach" {
  description = "Whether to attach the ENI to an instance."
  type        = bool
  default     = false
}

variable "instance_id" {
  description = "The instance to which the ENI will be associated."
  type        = string
  default     = null
}

variable "ipv4_count" {
  description = "The number of intranet IPv4s. When it is greater than 1, there is only one primary intranet IP. The others are auxiliary intranet IPs, which conflict with ipv4s."
  type        = number
  default     = null
}

variable "ipv4s" {
  description = " Applying for intranet IPv4s collection, conflict with ipv4_count. When there are multiple ipv4s, can only be one primary IP, and the maximum length of the array is 30."
  type        = list(object({
    ip      = string
    primary = bool
  }))
  default     = []
}