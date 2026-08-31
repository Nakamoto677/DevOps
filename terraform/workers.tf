resource "yandex_compute_instance" "worker" {
  count = 2

  hostname = "worker-${count.index + 1}"
  name     = "worker-${count.index + 1}"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.k8s_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBFgM6Va1mV5KK2yGt+t8VDalTF+rm8qtKyQRNra/5tX analdestroyer228@MacBook-Air-Mihail.local"

  }
}
