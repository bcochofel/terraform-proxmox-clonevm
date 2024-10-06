output "random_pet_id" {
  value = random_pet.server.id
}

output "server_name" {
  value = proxmox_vm_qemu.cloudinit-test.name
}

output "server_ip" {
  value = proxmox_vm_qemu.cloudinit-test.ipconfig0
}
