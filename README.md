# ansible-middleware-playground

Examples using https://github.com/ansible-middleware/amq

## Setup

Install the requirement roles
```bash
ansible-galaxy install -r requirements.yml
```

Set credentials to download AMQ. Service accounts can be used from https://console.redhat.com/iam/service-accounts/
```bash
export RHN_USERNAME="replace_me"
export RHN_PASSWORD="replace_me"
```

If you don't have any infrastructure, see [README.md](configure-aws%2FREADME.md). If you do, create [all.yml](inventory%2Fgroup_vars%2Fall.yml)

Check hosts are OK
```bash
ansible all -i inventory/group_vars/all.yml -m ansible.builtin.ping --user ec2-user --private-key ~/my_keypair.pem
```

## Clustered

```bash
ansible-playbook -i inventory/group_vars/all.yml deploy-amq-clustered.yml \
  -e rhn_username=${RHN_USERNAME} \
  -e rhn_password=${RHN_PASSWORD}
```
