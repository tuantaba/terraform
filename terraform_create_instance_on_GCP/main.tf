provider "google" {
  project = "empyrean-pixel-305606"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }
  # metadata_startup_script = "${file("startup.sh")}"

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }

	metadata = {
		ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
	}

  metadata_startup_script = "echo tuantb > /test.txt"   
  
	# connection {
	# 	type = "ssh"
	# 	user = "ubuntu"
	# 	host = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
	# 	private_key = "${file("~/.ssh/id_rsa")}"
	# }

}

# resource "google_compute_project_metadata_item" "username" {
#   key   = "ssh-keys"
#   value = "username:ssh-rsa <xxxxxxxx> <comment>"
# }

# resource "google_compute_network" "vpc_network" {
#   name                    = "terraform-network"
#   auto_create_subnetworks = "true"
# }

