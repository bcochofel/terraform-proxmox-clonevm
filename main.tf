provider "proxmox" {
  # Configuration options
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret

  pm_tls_insecure = true
}

provider "random" {
  # Configuration options
}

resource "random_pet" "server" {
  keepers = {
    name = var.vm_tmpl
  }
}

resource "proxmox_vm_qemu" "cloudinit-test" {
  name = random_pet.server.id
  desc = "A test for using terraform and cloudinit"

  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = "pve"

  # The template name to clone this vm from
  clone      = "ubuntu-noble-tmpl"
  full_clone = true

  # Activate QEMU agent for this VM
  agent = 1

  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 2048

  # Setup the Disks
  scsihw = "virtio-scsi-pci"
  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = 12
          storage = "local-lvm"
          format  = "raw"
        }
      }
      #      scsi1 {
      #        disk {
      #          size    = 20
      #          storage = "Proxmox-QNAP-LUN"
      #          format  = "raw"
      #        }
      #      }
    }
  }

  # Setup boot order
  boot = "order=scsi0"

  # Setup the network interface and assign a vlan tag: 256
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  #skip_ipv6 = true

  # Setup for cloud-init
  os_type = "cloud-init"

  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  #ipconfig0 = "ip=dhcp"
  ipconfig0 = "ip=192.168.68.250/22,gw=192.168.68.1"

  # start at boot
  onboot = true

  # Setup tags
  tags = "ubuntu,jammy"
}
