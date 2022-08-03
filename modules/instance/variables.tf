variable "instance_name" {
  description = "Name of the CVM instance"
  type        = string
}

variable "hostname" {
  description = "The hostname of the instance. "
  type        = string
  default     = ""
}

variable "instance_charge_type" {
  description = "The charge type of instance. Valid values are PREPAID, POSTPAID_BY_HOUR."
  type        = string
  default     = "POSTPAID_BY_HOUR"
  validation {
    condition     = contains(["PREPAID", "POSTPAID_BY_HOUR"], var.instance_charge_type)
    error_message = "Valid instance_charge_type: PREPAID, POSTPAID_BY_HOUR."
  }
}

variable "instance_charge_type_prepaid_period" {
  description = "The tenancy (time unit is month) of the prepaid instance."
  type        = number
  default     = 1
}

variable "instance_charge_type_prepaid_renew_flag" {
  description = "Auto renewal flag. Valid values: NOTIFY_AND_AUTO_RENEW, NOTIFY_AND_MANUAL_RENEW, DISABLE_NOTIFY_AND_MANUAL_RENEW."
  type        = string
  default     = "NOTIFY_AND_AUTO_RENEW"
  validation {
    condition     = contains([
      "NOTIFY_AND_AUTO_RENEW", "NOTIFY_AND_MANUAL_RENEW", "DISABLE_NOTIFY_AND_MANUAL_RENEW"
    ], var.instance_charge_type_prepaid_renew_flag)
    error_message = "Valid instance_charge_type_prepaid_renew_flag: NOTIFY_AND_AUTO_RENEW, NOTIFY_AND_MANUAL_RENEW, DISABLE_NOTIFY_AND_MANUAL_RENEW."
  }
}


variable "vpc_id" {
  description = "Id of the vpc at which the CVM instance locates."
  type        = string
}

variable "subnet_id" {
  description = "Id of the subnet at which the CVM instance locates."
  type        = string
}

variable "instance_type" {
  description = "The type of the instance. find a satisfied type by instance_family, cpu_core_count and memory_size"
  type        = string
  default     = null
}

variable "instance_family" {
  description = "Type series of the instance."
  type        = string
  default     = null
}

variable "cpu_core_count" {
  description = "The number of CPU cores of the instance."
  type        = number
  default     = null
}

variable "memory_size" {
  description = "Instance memory capacity, unit in GB."
  type        = number
  default     = null
}

variable "gpu_core_count" {
  description = "The number of GPU cores of the instance."
  type        = number
  default     = null
}

variable "os_name" {
  description = "A string to apply with fuzzy match to the os_name attribute on the image list returned by TencentCloud."
  type        = string
  default     = null
}

variable "image_id" {
  description = "The image to use for the instance."
  type        = string
  default     = null
}

variable "key_id" {
  description = "SSH Key id for instance login."
  type        = string
  default = null
}


variable "system_disk_type" {
  description = "System disk type."
  type        = string
  default     = "CLOUD_PREMIUM"
  validation {
    condition     = contains(["CLOUD_PREMIUM", "CLOUD_SSD"], var.system_disk_type)
    error_message = "Valid system_disk_type: CLOUD_PREMIUM, CLOUD_SSD."
  }
}

variable "system_disk_size" {
  description = "Size of the system disk in GiB"
  type        = number
  default     = 50
}

variable "data_disks" {
  description = "List of data disks"
  type        = list(object({
    # CLOUD_PREMIUM, CLOUD_SSD
    type = string
    # If disk type is CLOUD_SSD, the size range is [100, 16000], and the others are [10-16000]
    size = number
  }))
  default     = []
}

variable "project_id" {
  description = "The project the instance belongs to, default to 0."
  type        = number
  default     = 0
}

variable "private_ip" {
  description = "The private IP to be assigned to this instance, must be in the provided subnet and available."
  type        = string
  default     = null
}

variable "allocate_public_ip" {
  description = "Associate a public IP address or not."
  type        = bool
  default     = false
}

variable "internet_max_bandwidth_out" {
  description = "Maximum outgoing bandwidth to the public network, measured in Mbps."
  type        = number
  default     = 1
}

variable "security_groups" {
  description = "A list of security group IDs to associate with."
  type        = list(string)
}

variable "enis" {
  description = "List of ENIs."
  type        = list(object({
    # IPv4 address of the ENI
    ip = optional(string)
  }))
  default     = []
}

variable "eips" {
  description = "List of EIPs."
  type        = list(object({
    # whether to associate this EIP to ENI. if false the EIP will be associated to the main interface
    # if true an ENI will be created and the ENI will be associated to it
    associate_eni              = optional(bool)
    # if associate_eni is true, this argument assign a private IP to the newly created ENI
    eni_private_ip             = optional(string)
    # charge type: BANDWIDTH_PACKAGE BANDWIDTH_POSTPAID_BY_HOUR TRAFFIC_POSTPAID_BY_HOUR
    internet_charge_type       = optional(string)
    # max bandwidth
    internet_max_bandwidth_out = optional(number)
    #
    internet_service_provider = optional(string)
  }))
  default     = []
}

variable "tags" {
  type = map(string)
  default = {}
}