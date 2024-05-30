# Setting up the VMs
## Terraform
The VMs are set up using [Terraform](../terraform/main.tf)
They use the t-clo-902-bdx-2 resource group and VLAN.

## Kubespray
To configure the VMs to act as kubernetes hosts, we used [Kubespray](https://kubespray.io/#/)
This allowed us to configure them without the hassle of writing our own ansible playbook.

To set them up, we created a dynamic inventory using their [inventory builder](https://github.com/kubernetes-sigs/kubespray/blob/master/contrib/inventory_builder/inventory.py). We tweaked it to change ```ansible_hostname``` to their public IPs, and made sure to have the node1 be our control plane. Then we ran the first playbook, [reset.yml](https://github.com/kubernetes-sigs/kubespray/blob/master/playbooks/reset.yml) as a cleanup, then the actual playbook that creates the nodes, [cluster.yml](https://github.com/kubernetes-sigs/kubespray/blob/master/playbooks/cluster.yml).