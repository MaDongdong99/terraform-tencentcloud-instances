
variable "instance_type" {
  description = "Type of the instance."
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "The available zone that the CVM instance locates at."
  type        = string
}

variable "instance_family" {
  description = "Type series of the instance."
  type        = string
  default     = null
}

variable "cpu_core_count" {
  description = "The number of CPU cores of the instance."
  type        = number
}

variable "memory_size" {
  description = "Instance memory capacity, unit in GB."
  type        = number
}

variable "gpu_core_count" {
  description = "The number of GPU cores of the instance."
  type        = number
  default     = null
}