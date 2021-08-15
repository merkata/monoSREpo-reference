package main

deny[msg] {
encrypted := input.terraform.backend.s3.encrypt
not encrypted
msg := "S3 backend needs to be encrypted!"
}
