# configure-aws

If you don't already have any infrastructure, the playbooks here can provide you with several RHEL instances:
- bootstrap node
- 3 AMQ nodes: amq1, amq2 and amq3

## Instructions

Set your AWS credentials
```bash
export AWS_ACCESS_KEY_ID="replace_me"
export AWS_SECRET_ACCESS_KEY="replace_me"
```

Get a Automation Hub token from https://console.redhat.com/ansible/automation-hub/token
```bash
export ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN="replace_me"
```

Deploy the AWS infrastructure (_run from local_)
```bash
ansible-playbook deploy.yml \
  -e aws_access_key=${AWS_ACCESS_KEY_ID} \
  -e aws_secret_key=${AWS_SECRET_ACCESS_KEY} \
  -e ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN=${ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN}
```