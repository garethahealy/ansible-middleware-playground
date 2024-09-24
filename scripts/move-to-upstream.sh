#!/usr/bin/env bash

topology_test="federated"

sed -i -e 's/amq_broker_/activemq_/g' playbooks/deploy-amq-${topology_test}.yml
sed -i -e 's/redhat.amq_broker.amq_broker/middleware_automation.amq.activemq/g' playbooks/deploy-amq-${topology_test}.yml
sed -i -e 's/amq_broker_/activemq_/g' inventory/${topology_test}.yml

#sed -i -e 's/redhat.amq_broker.amq_broker_uninstall/middleware_automation.amq.activemq_uninstall/g' playbooks/remove-amq.yml
#sed -i -e 's/middleware_automation.amq.activemq_uninstall/redhat.amq_broker.amq_broker_uninstall/g' playbooks/remove-amq.yml
deploy-amq-.yml
# ansible-galaxy collection install git+https://github.com/ansible-middleware/amq.git,main