# sor-limited-project
Sor Limited project using terraform to provision azure infrastructure 

# sor-limited-project

This project uses **Terraform** to deploy an Azure infrastructure that includes:

- A Resource Group
- Virtual Network and Subnets
- Network Security Group
- Virtual Machines in an Availability Set
- Load Balancer
- Azure Bastion Host

The infrastructure is intended to demonstrate a simple yet robust Azure setup suitable for applications requiring high availability and secure access.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Resources Created](#resources-created)
- [Usage](#usage)
- [Variables](#variables)
- [Generating SSH Keys](#generating-ssh-keys)
- [Cleanup](#cleanup)
- [Acknowledgments](#acknowledgments)

## Prerequisites

- **Azure Subscription**: An active Azure subscription is required.
- **Terraform**: Install [Terraform](https://www.terraform.io/downloads.html) version `>= 1.0`.
- **Azure CLI**: Install the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
- **SSH Key Pair**: A public and private SSH key pair for VM authentication.

## Project Structure

```bash
sor-limited-project/
├── main.tf
├── vm.tf
├── networking.tf
├── loadbalancer.tf
├── bastion.tf
├── variables.tf
├── providers.tf
├── azure_vm_key.pub
├── README.md
```

- **main.tf**: Defines the Resource Group, Virtual Network, and Subnets.
- **vm.tf**: Creates two Virtual Machines and an Availability Set.
- **networking.tf**: Sets up Network Interfaces and Network Security Groups.
- **loadbalancer.tf**: Configures the Load Balancer and its associations.
- **bastion.tf**: Deploys the Azure Bastion Host and Public IP.
- **variables.tf**: Contains variable definitions with default values.
- **providers.tf**: Specifies the required Terraform providers.
- **azure_vm_key.pub**: The public SSH key used for VM authentication.
- **README.md**: Documentation for the project.

## Resources Created

### Resource Group

- A resource group with a unique name using a random pet name and prefix.

### Networking

- **Virtual Network (VNet)**: A VNet with an address space of `10.0.0.0/16`.
- **Subnets**:
  - **AzureBastionSubnet**: Required subnet for the Bastion Host.
  - **subnet-2**: Subnet where VMs and Load Balancer are deployed.
- **Network Security Group (NSG)**: Controls inbound and outbound traffic to subnet-2.

### Compute

- **Availability Set**: Ensures VMs are distributed across fault and update domains.
- **Virtual Machines**:
  - **vm1** and **vm2**: Ubuntu Linux VMs with SSH key authentication.
- **Network Interfaces**: NICs attached to VMs and associated with the NSG.

### Load Balancer

- **Load Balancer**: Distributes traffic across VMs.
- **Backend Address Pool**: Contains the NICs of vm1 and vm2.
- **Health Probe**: Checks VM health on port 80.
- **Load Balancing Rule**: Routes traffic from frontend to backend VMs.

### Azure Bastion Host

- Provides secure and seamless RDP/SSH connectivity to VMs over SSL.

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/TEM-WONDER/sor-limited-project.git
cd sor-limited-project
```

### 2. Authenticate with Azure

Login using the Azure CLI:

```bash
az login
```

Set the desired subscription (if you have multiple):

```bash
az account set --subscription "your-subscription-id"
```

### 3. Generate SSH Key Pair

If you haven't already, generate an SSH key pair:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ./azure_vm_key
```

This creates `azure_vm_key` (private key) and `azure_vm_key.pub` (public key) in the project directory.

### 4. Initialize Terraform

Initialize the Terraform workspace:

```bash
terraform init
```

### 5. Review the Execution Plan

Review the resources that will be created:

```bash
terraform plan
```

### 6. Apply the Configuration

Deploy the infrastructure:

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 7. Accessing the VMs

Use Azure Bastion to connect to the VMs securely:

1. Go to the Azure Portal.
2. Navigate to the deployed resource group.
3. Open the Bastion Host resource.
4. Use the Bastion service to SSH into `vm1` or `vm2`.

**Note**: Since password authentication is disabled, use your private SSH key (`azure_vm_key`) for authentication.

## Variables

The `variables.tf` file contains the following variables:

- **public_key_loc**
  - **Description**: Path to the SSH public key file.
  - **Default**: `./azure_vm_key.pub`
- **resource_group_location**
  - **Description**: Azure region for resource deployment.
  - **Default**: `uksouth`
- **resource_group_name_prefix**
  - **Description**: Prefix for resource group name.
  - **Default**: `sor`

### Overriding Default Variables

You can override default variable values by:

- Creating a `terraform.tfvars` file.
- Setting variables through command-line flags.

**Example `terraform.tfvars`:**

```hcl
public_key_loc = "./azure_vm_key.pub"
resource_group_location = "eastus"
resource_group_name_prefix = "myproject"
```

## Generating SSH Keys

To generate an SSH key pair for authentication with the VMs:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ./azure_vm_key
```

- **`-t rsa`**: Specifies RSA algorithm.
- **`-b 4096`**: Sets the key length to 4096 bits.
- **`-C "your_email@example.com"`**: Adds a comment.
- **`-f ./azure_vm_key`**: Specifies the output file names.

Ensure the public key (`azure_vm_key.pub`) is in the project directory and the `public_key_loc` variable points to it.

## Cleanup

To destroy the resources created by this project:

```bash
terraform destroy
```

Type `yes` when prompted to confirm.

## Acknowledgments

- **Terraform**: Infrastructure as Code tool used for this project.
- **Azure**: Cloud service provider.
- **HashiCorp**: Creators of Terraform.
- **Community Resources**: Various tutorials and documentation that inspired this project.

---

For any issues or contributions, please open an issue or pull request on the project's GitHub repository.