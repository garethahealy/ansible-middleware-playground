SHELL := /bin/bash

.PHONY: help configure-aws \
	deploy-custom deploy-clustered deploy-federated deploy-master-slave \
	test-custom test-clustered test-federated test-master-slave \
	remove

help:
	@echo "Available targets:"
	@echo "  configure-aws         Run configure-aws/deploy.yml"
	@echo "  deploy-custom         Deploy single broker (custom)"
	@echo "  deploy-clustered      Deploy clustered brokers"
	@echo "  deploy-federated      Deploy federated brokers"
	@echo "  deploy-master-slave   Deploy master/slave brokers"
	@echo "  test-custom           Test single broker (custom)"
	@echo "  test-clustered        Test clustered brokers"
	@echo "  test-federated        Test federated brokers"
	@echo "  test-master-slave     Test master/slave brokers"
	@echo "  remove                Remove AMQ installations"

configure-aws:
	ansible-playbook configure-aws/deploy.yml \
		--vault-password-file=configure-aws/vault-password.sec \
		-e SSH_KEY_VAULT_PASS=$${SSH_KEY_VAULT_PASS} \
		-e ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN=$${ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN}

deploy-custom:
	ansible-playbook -i inventory/custom.yml playbooks/deploy-amq-custom.yml \
		-e rhn_username=$${RHN_USERNAME} \
		-e rhn_password=$${RHN_PASSWORD}

deploy-clustered:
	ansible-playbook -i inventory/clustered.yml playbooks/deploy-amq-clustered.yml \
		-e rhn_username=$${RHN_USERNAME} \
		-e rhn_password=$${RHN_PASSWORD}

deploy-federated:
	ansible-playbook -i inventory/federated.yml playbooks/deploy-amq-federated.yml \
		-e rhn_username=$${RHN_USERNAME} \
		-e rhn_password=$${RHN_PASSWORD}

deploy-master-slave:
	ansible-playbook -i inventory/master-slave.yml playbooks/deploy-amq-master-slave.yml \
		-e rhn_username=$${RHN_USERNAME} \
		-e rhn_password=$${RHN_PASSWORD}

test-custom:
	ansible-playbook -i inventory/test.yml playbooks/test-amq-custom.yml

test-clustered:
	ansible-playbook -i inventory/test.yml playbooks/test-amq-clustered.yml

test-federated:
	ansible-playbook -i inventory/test.yml playbooks/test-amq-federated.yml

test-master-slave:
	ansible-playbook -i inventory/test.yml playbooks/test-amq-master-slave.yml

remove:
	ansible-playbook -i inventory/all.yml playbooks/remove-amq.yml
