# Terraform module to create Proxmox VM from template

This is just an example on own to use Terraform to deploy a VM in Proxmox using a template created by [this](https://github.com/bcochofel/packer-proxmox-ubuntu) Packer repository.

## Proxmox Setup

Create ```terraform``` group, user and set permissions

```bash
pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.AllocateTemplate Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
pveum user add terraform@pve --password <password>
pveum aclmod / -user terraform@pve -role TerraformProv
```

Create API Token

```bash
pveum user token add terraform@pve terraform-automation --privsep 0
```

**Note:** The above command will output the values you need to use in to authenticate

## Terraform Configuration

This repository uses HCP Terraform to store the state file.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.1-rc4 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 3.0.1-rc4 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.cloudinit-test](https://registry.terraform.io/providers/Telmate/proxmox/3.0.1-rc4/docs/resources/vm_qemu) | resource |
| [random_pet.server](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pm_api_token_id"></a> [pm\_api\_token\_id](#input\_pm\_api\_token\_id) | This is an API token you have previously created for a specific user. | `string` | n/a | yes |
| <a name="input_pm_api_token_secret"></a> [pm\_api\_token\_secret](#input\_pm\_api\_token\_secret) | This uuid is only available when the token was initially created. | `string` | n/a | yes |
| <a name="input_pm_api_url"></a> [pm\_api\_url](#input\_pm\_api\_url) | This is the target Proxmox API endpoint. | `string` | n/a | yes |
| <a name="input_vm_tmpl"></a> [vm\_tmpl](#input\_vm\_tmpl) | Name of the VM Template to clone from | `string` | `"ubuntu-jammy-tmpl"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## References

- [Proxmox Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)
- [Random Provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs)
- [HCP Terraform](https://app.terraform.io)
