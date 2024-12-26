###cloud vars
variable "token" {
  type        = string
  default = "<yc-token>"
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  default = "<cloud-id>"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default = "<folder-id>"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

### SA variable
variable "sa_name" {
  type        = string
  default     = "netology-sa"
  description = "serviceAccount name"
}

variable "key_name" {
  type        = string
  default     = "netology_key"
  description = "key for sa name"
}


### Bucket variable
variable "bucket_name" {
  type        = string
  default     = "netologybucketdiplom"
  description = "S3 bucket name"
}


### VPC variable
variable "vpc_name" {
  type        = string
  default     = "netology"
  description = "VPC network name"
}

variable "subnet_name" {
 type        = list(string)
 description = "Subnet name values"
 default     = ["main-a", "main-b", "main-c"]
}

variable "subnet_cidrs" {
 type        = list(string)
 description = "Subnet CIDR values"
 default     = ["10.10.10.0/24", "10.10.15.0/24", "10.10.20.0/24"]
}

variable "zone" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}


### compute config
variable "vm-control-node" {
  type = map(number)
  default = {
      cores = 4
      memory = 8
      core_fraction = 100
  }
}

### worker config
variable "vm-worker-node" {
  type = map(number)
  default = {
      cores = 4
      memory = 4
      core_fraction = 20
  }
}

variable "node_count" {
 type        = list(string)
 description = "number of control and worker nodes"
 default     = ["vm-control-node", "vm-worker-node-1", "vm-worker-node-2"]
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex compute image family"
}