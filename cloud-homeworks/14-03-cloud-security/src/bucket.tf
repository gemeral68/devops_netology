resource "yandex_storage_bucket" "netology" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "netology1"
  acl    = "public-read"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "netology" {
  bucket = "netology1"
  key    = "m1000x1000.jpg"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  source = "m1000x1000.jpg"
}


resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "terraform"
}


resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}


resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}


resource "yandex_kms_symmetric_key" "key-a" {
  name              = "net"
  description       = "net"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}