variable "env" {
  type        = string
  description = "Deployment environment"
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
}
