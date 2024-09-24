# ansible-middleware-playground

Examples using https://github.com/ansible-middleware/amq

## Setup

If you don't have any infrastructure, see [README.md](configure-aws%2FREADME.md). If you do, create an inventory file like [samples](inventory/samples)

Check hosts are OK (_run from bootstrap_)
```bash
ansible all -i inventory/all.yml -m ansible.builtin.ping --user ec2-user --private-key ~/ec2_keypair.pem
```

Install the required roles
```bash
ansible-galaxy install -r requirements.yml
```

Set credentials to download AMQ. Service accounts can be used from https://console.redhat.com/iam/service-accounts/
```bash
export RHN_USERNAME="replace_me"
export RHN_PASSWORD="replace_me"
```

Set your AWS credentials
```bash
export AWS_ACCESS_KEY_ID="replace_me"
export AWS_SECRET_ACCESS_KEY="replace_me"
```

## Single Broker

Deploy single broker with a custom broker.xml
```bash
ansible-playbook -i inventory/custom.yml playbooks/deploy-amq-custom.yml \
  -e rhn_username=${RHN_USERNAME} \
  -e rhn_password=${RHN_PASSWORD}
```

Test single broker configuration
```bash
ansible-playbook playbooks/test-amq-custom.yml \
  -e aws_access_key=${AWS_ACCESS_KEY_ID} \
  -e aws_secret_key=${AWS_SECRET_ACCESS_KEY}
```

## Master/Slave Broker

Deploy master/slave broker, with shared storage
```bash
ansible-playbook -i inventory/master-slave.yml playbooks/deploy-amq-master-slave.yml \
  -e rhn_username=${RHN_USERNAME} \
  -e rhn_password=${RHN_PASSWORD} \
  -e aws_access_key=${AWS_ACCESS_KEY_ID} \
  -e aws_secret_key=${AWS_SECRET_ACCESS_KEY}
```

Test master/slave broker configuration
```bash
ansible-playbook -i inventory/master-slave-test.yml playbooks/test-amq-master-slave.yml \
  -e aws_access_key=${AWS_ACCESS_KEY_ID} \
  -e aws_secret_key=${AWS_SECRET_ACCESS_KEY}
```

## 3 Clustered Brokers

Deploy clustered brokers
```bash
ansible-playbook -i inventory/clustered.yml playbooks/deploy-amq-clustered.yml \
  -e rhn_username=${RHN_USERNAME} \
  -e rhn_password=${RHN_PASSWORD}
```

Test clustered brokers configuration
```bash
ansible-playbook playbooks/test-amq-clustered.yml \
  -e aws_access_key=${AWS_ACCESS_KEY_ID} \
  -e aws_secret_key=${AWS_SECRET_ACCESS_KEY}
```

## 3 Federated Brokers

Deploy federated brokers
```bash
ansible-playbook -i inventory/federated.yml playbooks/deploy-amq-federated.yml \
  -e rhn_username=${RHN_USERNAME} \
  -e rhn_password=${RHN_PASSWORD}
```

Test federated brokers configuration
```bash
ansible-playbook playbooks/test-amq-clustered.yml \
  -e aws_access_key=${AWS_ACCESS_KEY_ID} \
  -e aws_secret_key=${AWS_SECRET_ACCESS_KEY}
```

## Remove an installation

```bash
ansible-playbook -i inventory/all.yml playbooks/remove-amq.yml \
  -e aws_access_key=${AWS_ACCESS_KEY_ID} \
  -e aws_secret_key=${AWS_SECRET_ACCESS_KEY}
```
