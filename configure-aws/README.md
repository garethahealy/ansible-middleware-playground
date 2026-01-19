# configure-aws

If you don't already have any infrastructure, the playbooks here can provide you with several RHEL instances:
- bootstrap node
- 3 AMQ nodes: amq1, amq2 and amq3

## Instructions

Set your AWS credentials (env vars or profile)
```bash
export AWS_ACCESS_KEY_ID="replace_me"
export AWS_SECRET_ACCESS_KEY="replace_me"
```

Get an Automation Hub token from https://console.redhat.com/ansible/automation-hub/token
```bash
export ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN="replace_me"
```

Deploy the AWS infrastructure (_run from local_)
```bash
ansible-playbook deploy.yml \
  --vault-password-file=vault-password.sec \
  -e SSH_KEY_VAULT_PASS=${SSH_KEY_VAULT_PASS} \
  -e ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN=${ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN}
```

If the above has already been run, it can also be used in [CI](../.github/workflows/test-release.yaml) via
```bash
--skip-tags blank
```
