variable "env" {
  type        = string
  description = "Deployment environment"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.env)
    error_message = "env must be dev, staging, or prod."
  }
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
  default     = {}
}