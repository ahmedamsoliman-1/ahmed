# Define the Google provider with the necessary credentials and project information
provider "google" {
  project = var.project_id
  region  = var.region
  # Uncomment and configure the following if using a service account key
  # credentials = file("<path-to-service-account-key>.json")
}

# Configure the Terraform backend to use Terraform Cloud
terraform {
  backend "remote" {
    organization = "ahmedalimsoliman-org"

    workspaces {
      name = "aamsdn-ws-gcp2-dns-compined"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Create the DNS Zone
resource "google_dns_managed_zone" "aamsdn" {
  name     = var.zdns_name
  dns_name = var.ddns_name
  description = "Managed zone for aamsdn.com"
}

# # Create the A record
# resource "google_dns_record_set" "a_record" {
#   name         = "${var.dns_name}."
#   managed_zone = google_dns_managed_zone.aamsdn.name
#   type         = "A"
#   ttl          = 300

#   rrdatas = [var.ingress_ip]
# }
# Create the A record for the subdomain
resource "google_dns_record_set" "argo_subdomain" {
  name         = "${var.argo_subdomain}.${var.dns_name}."
  managed_zone = google_dns_managed_zone.aamsdn.name
  type         = "A"
  ttl          = 300

  rrdatas = [var.ingress_ip]
}
resource "google_dns_record_set" "portfolio_subdomain" {
  name         = "${var.portfolio_subdomain}.${var.dns_name}."
  managed_zone = google_dns_managed_zone.aamsdn.name
  type         = "A"
  ttl          = 300

  rrdatas = [var.ingress_ip]
}

variable "project_id" { type = string }
variable "region" { type = string }

variable "ingress_ip" { type = string }

variable "dns_name" { default = "aamsd.com" }
variable "ddns_name" { default = "aamsd.com." }
variable "zdns_name" { default = "aamsd-com" }
variable "argo_subdomain" { default = "argo" }
variable "portfolio_subdomain" { default = "portfolio" }

variable "recipients" { default = "Mohamed Ali Ali Mohamed Soliman" }
variable "mobile" { default = "+971507065214" }
variable "email" { default = "ahmed-3010@hotmail.com" }
variable "organization" { default = "AAMSD" }
variable "regioncode" { default = "AE" }
variable "postalcode" { default = "00000" }
variable "administrative_area" { default = "Abu Dhabi" }
variable "locality" { default = "Abu Dhabi Khalifa City" }
variable "address" { default = "Abu Dhabi Khalifa City" }

# # # # # OUTPUT
output "name_servers" { value = google_dns_managed_zone.aamsdn.name_servers }
output "domain_name" { value = google_dns_managed_zone.aamsdn.name }
output "ingress_ip_debug" { value = var.ingress_ip }