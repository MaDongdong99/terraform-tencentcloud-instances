variable "internet_charge_type" {
  description = "The charge type of EIP. Valid value: BANDWIDTH_PACKAGE, BANDWIDTH_POSTPAID_BY_HOUR and TRAFFIC_POSTPAID_BY_HOUR."
  type        = string
  default     = "TRAFFIC_POSTPAID_BY_HOUR"
  validation {
    condition     = contains([
      "BANDWIDTH_PACKAGE", "BANDWIDTH_POSTPAID_BY_HOUR", "TRAFFIC_POSTPAID_BY_HOUR"
    ], var.internet_charge_type == null ? "TRAFFIC_POSTPAID_BY_HOUR" : var.internet_charge_type )
    error_message = "Valid internet_charge_type:  BANDWIDTH_PACKAGE, BANDWIDTH_POSTPAID_BY_HOUR and TRAFFIC_POSTPAID_BY_HOUR."
  }
}

variable "internet_max_bandwidth_out" {
  description = "The bandwidth limit of EIP, unit is Mbps."
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "Id of the vpc at which the ENI locates."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Id of the subnet at which the ENI locates."
  type        = string
  default     = null
}

variable "associate_to" {
  description = "Which kind of target the EIP will be associated to. Valid value: ENI, INSTANCE and NONE."
  type        = string
  default     = "NONE"
  validation {
    condition     = contains(["ENI", "INSTANCE", "NONE"], var.associate_to)
    error_message = "Valid internet_charge_type:  ENI, INSTANCE and NONE."
  }
}

variable "eni_private_ip" {
  description = "Private IP of the newly created ENI."
  type        = string
  default     = null
}

variable "instance_id" {
  description = "The instance to which the EIP will be associated."
  type        = string
  default     = null
}

variable "internet_service_provider" {
  default = "CMCC"  // BGP, CMCC, CTCC and CUCC
}