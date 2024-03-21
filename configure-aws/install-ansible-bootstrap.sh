boostrap_node="replace_me"
amq1_node="replace_me"
amq2_node="replace_me"
amq3_node="ireplace_me"

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user

python3 -m pip install --user ansible
ansible --version
ansible-playbook --version

ansible-galaxy collection install redhat.amq_broker

# Bootstrap node
scp -i my_keypair.pem my_keypair.pem ec2-user@${boostrap_node}:~/.

eval "$(ssh-agent -s)"
ssh-add ~/my_keypair.pem

# AMQ nodes
ssh-keyscan -H ${amq1_node} >> ~/.ssh/known_hosts
ssh-keyscan -H ${amq2_node} >> ~/.ssh/known_hosts
ssh-keyscan -H ${amq3_node} >> ~/.ssh/known_hosts

ansible all -i inventory/group_vars/all.yml -m ansible.builtin.ping

scp -i my_keypair.pem amq-broker-7.11.6-bin.zip  ec2-user@${boostrap_node}:~/.