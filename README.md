# Self-Service Infrastructure Provisioning with Terraform on Azure

This repository enables **fully automated** provisioning of Azure Virtual Machines using **Terraform and GitHub Actions**, ideal for cloud engineers, DevOps learners, and professionals looking to streamline infrastructure deployments.

---

## What This Project Does

- ✅ Provision Azure Resource Group, Virtual Network, Subnet, NIC, and Windows VM
- ✅ Uses a GitOps-style workflow (pull request → plan → approve → apply)
- ✅ Fully modular and scalable — create as many VMs as you want with just `.tfvars`
- ✅ Requires **no manual Azure setup** — everything is managed through Terraform

---

## 📁 Folder Structure

```
.
├── .github/workflows/terraform-vm.yml  # CI/CD pipeline using GitHub Actions
├── envs/dev-vm/                        # Environment-specific Terraform configs
│   ├── main.tf
│   ├── backend.tf
│   └── variables.tf
├── modules/virtual-machine/           # Reusable module for creating a VM
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── requests/                           # .tfvars files define VM-specific configs
│   └── dev-vm.tfvars
└── README.md
```

---

## Secrets and Azure Authentication

To deploy infrastructure on your Azure subscription, you’ll need to create a **Service Principal** and save its credentials as **GitHub Secrets**.

### 1. ✅ Generate Azure Credentials

Open PowerShell or Terminal and run:

```bash
az ad sp create-for-rbac --name "terraform-sp" --role="Contributor" --scopes="/subscriptions/<your-subscription-id>" --sdk-auth
```

You'll receive a JSON response like this:

```json
{
  "clientId": "...",
  "clientSecret": "...",
  "subscriptionId": "...",
  "tenantId": "..."
}
```

### 2. ✅ Set These Values as GitHub Repository Secrets

Go to your GitHub repo:

**Settings → Secrets → Actions → New Repository Secret**  
Add the following secrets (name them exactly like this):

| Secret Name              | Value (from Azure output)     |
|--------------------------|-------------------------------|
| `ARM_CLIENT_ID`          | clientId                      |
| `ARM_CLIENT_SECRET`      | clientSecret                  |
| `ARM_SUBSCRIPTION_ID`    | subscriptionId                |
| `ARM_TENANT_ID`          | tenantId                      |

> **Your credentials are never committed in the code. All keys must be added manually for security.**

---

## Note on `-lock=false`

For **demo purposes only**, the Terraform workflow uses:
```bash
terraform plan -lock=false
```

> **This is not a best practice.** In production, always let Terraform handle state locking to avoid corruption when multiple users are deploying.

---

## How It Works

1. Fork or clone this repo
2. Add your own `.tfvars` file inside `requests/`
3. Create a branch and update your `.tfvars` with desired VM name, region, size, etc.
4. Create a **Pull Request** → GitHub Actions will automatically run `terraform plan`
5. When PR is merged to `main`, `terraform apply` is triggered to deploy the VM

---

## Example `.tfvars` File

```hcl
name                = "testvm01"
location            = "eastus"
resource_group_name = "demo-rg"
vm_size             = "Standard_B1s"
admin_username      = "azureuser"
admin_password      = "SecurePass123!"
environment         = "dev"
team                = "devops"
```

---

## Prerequisites

- [x] Terraform installed (>= 1.6.0)
- [x] Azure CLI installed and authenticated
- [x] GitHub repository secrets configured
- [x] A valid Azure subscription (free/student accounts work too)

---

## For Beginners

Don't worry — this project is structured to be super easy:
- ✅ Everything you need is in one place
- ✅ Prebuilt module and environment folder
- ✅ GitHub Actions takes care of CI/CD
- ✅ Just change a few variables and commit — the rest is automated

---

## Contributing

Feel free to fork, customize, and contribute to improve this template.  
PRs are welcome!

Connect on LinkedIn @Shubhamshah30

---

## License

This project is MIT licensed — free to use and modify.
