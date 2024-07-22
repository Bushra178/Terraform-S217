variable "app_prefix" {
  description = "prefix for resources"
  type = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}
