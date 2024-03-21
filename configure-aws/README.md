# configure-aws

If you dont already have any infrastrucutre, the playbooks here can provide you with:
- bootstrap node
- 3 RHEL instances, named: amq1, amq2 and amq3

[ansible.cfg](configure-bootstrap%2Ftemplates%2Fansible.cfg) contains a token that needs replacing and putting in [files](configure-bootstrap%2Ffiles)/files

## Instructions

Install the requirement roles
```bash
ansible-galaxy install -r requirements.yml
```

Set your AWS credentials
```bash
export AWS_ACCESS_KEY_ID="replace_me"
export AWS_SECRET_ACCESS_KEY="replace_me"
```

Deploy the AWS infrastructure
```bash
ansible-playbook deploy.yml
```

Update the `bootstrap` node with the required ansible bits
```bash
ansible-playbook -i inventory/group_vars/bootstrap.yml configure-bootstrap.yml -e aws_access_key=${AWS_ACCESS_KEY_ID} -e aws_secret_key=${AWS_SECRET_ACCESS_KEY}
```