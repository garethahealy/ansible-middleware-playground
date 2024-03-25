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

If you don't have any infrastructure, see [README.md](configure-aws%2FREADME.md). If you do, create an inventory file like [sample.yml](inventory%2Fsample.yml))

Check hosts are OK
```bash
ansible all -i inventory/all.yml -m ansible.builtin.ping --user ec2-user --private-key ~/my_keypair.pem
```

## Single Broker **NOT RELEASED IN DOWNSTREAM YET*

Deploy single broker with a custom broker.xml
```bash
ansible-playbook -i inventory/all.yml deploy-amq-custom.yml \
  -e rhn_username=${RHN_USERNAME} \
  -e rhn_password=${RHN_PASSWORD}
```

## Master/Slave Broker

Deploy master/slave broker, with shared storage
```bash
ansible-playbook -i inventory/all.yml deploy-amq-masterslave.yml \
  -e rhn_username=${RHN_USERNAME} \
  -e rhn_password=${RHN_PASSWORD}
```

Test master/slave broker configuration
```bash
ansible-playbook -i inventory/amq1.yml test-amq-masterslave.yml \
  -e aws_access_key=${AWS_ACCESS_KEY_ID} \
  -e aws_secret_key=${AWS_SECRET_ACCESS_KEY}
```

## 3 Clustered Brokers

Deploy clustered brokers
```bash
ansible-playbook -i inventory/all.yml deploy-amq-clustered.yml \
  -e rhn_username=${RHN_USERNAME} \
  -e rhn_password=${RHN_PASSWORD}
```

Test clustered brokers configuration
```bash
ansible-playbook test-amq-clustered.yml \
  -e aws_access_key=${AWS_ACCESS_KEY_ID} \
  -e aws_secret_key=${AWS_SECRET_ACCESS_KEY}
```

## Remove an installation

```bash
ansible-playbook -i inventory/all.yml remove-amq.yml
```
