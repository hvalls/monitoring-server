## Monitoring server

This repo contains infrastructure as code to setup an AWS EC2 instance running Prometheus and Grafana. Feel free to clone the repo and customize it according your needs.

### Requirements

Terraform and Ansible must be installed in your machine.

### Infra

- AWS EC2 instance with [Amazon Linux 2023](https://docs.aws.amazon.com/linux/al2023/ug/what-is-amazon-linux.html) installed by default. To replace this OS, change `ami_id` variable in [variables.tf](./infra/variables.tf)*
- VPC
- Subnet
- Internet Gateway
- Security Group

*[Ansible provisioning playbook](./ansible/playbook.yml) only supports RPM-based operating systems.

### Provisioner

Once AWS EC2 machine is ready, Ansible provisioning is triggered to install Prometheus and Grafana.

### Run
```
$ cd infra/
$ terraform plan --out plan.tfplan
$ terraform apply plan.tfplan
```
