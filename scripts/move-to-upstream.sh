#!/usr/bin/env bash

topology_test="federated"

upstream() {
    echo "Converting to upstream middleware_automation.amq collection..."

    # Update deploy playbook
    sed -i -e 's/amq_broker_/activemq_/g' playbooks/deploy-amq-${topology_test}.yml
    sed -i -e 's/redhat.amq_broker.amq_broker/middleware_automation.amq.activemq/g' playbooks/deploy-amq-${topology_test}.yml
    sed -i -e 's/amq_broker_/activemq_/g' inventory/${topology_test}.yml

    sed -i -e 's/redhat.amq_broker.amq_broker_uninstall/middleware_automation.amq.activemq_uninstall/g' playbooks/remove-amq.yml

    echo "Converted to upstream collection. Run: ansible-galaxy collection install git+https://github.com/ansible-middleware/amq.git,main"
}

downstream() {
    echo "Converting to downstream redhat.amq_broker collection..."

    sed -i -e 's/activemq_/amq_broker_/g' playbooks/deploy-amq-${topology_test}.yml
    sed -i -e 's/middleware_automation.amq.activemq/redhat.amq_broker.amq_broker/g' playbooks/deploy-amq-${topology_test}.yml
    sed -i -e 's/activemq_/amq_broker_/g' inventory/${topology_test}.yml
    sed -i -e 's/middleware_automation.amq.activemq_uninstall/redhat.amq_broker.amq_broker_uninstall/g' playbooks/remove-amq.yml

    echo "Converted to downstream collection."
}

usage() {
    echo "Usage: $0 {upstream|downstream}"
    echo ""
    echo "Commands:"
    echo "  upstream   Convert to use upstream middleware_automation.amq collection"
    echo "  downstream Convert to use downstream redhat.amq_broker collection"
    echo ""
    echo "Example:"
    echo "  $0 upstream"
    echo "  $0 downstream"
}

# Main script logic
case "${1:-}" in
    upstream)
        upstream
        ;;
    downstream)
        downstream
        ;;
    -h|--help|help)
        usage
        ;;
    *)
        echo "Error: Invalid command '${1:-}'" >&2
        echo "" >&2
        usage
        exit 1
        ;;
esac
