variable "prefix" { // prefix 변수 이름
  description = "Prefix for all resources"
  default     = "dev" // prefix 변수의 값은 dev
}

variable "region" {
  description = "region"
  default     = "ap-northeast-2"
}

variable "nickname" {
  description = "nickname"
  default     = "ljy5314"
}