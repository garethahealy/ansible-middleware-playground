#!/usr/bin/env bash

rm -f inventory/*.yml
rm -f configure-aws/roles/configure_bootstrap/files/*.pem
rm -f configure-aws/roles/configure_bootstrap/files/*.pem.enc
rm -f configure-aws/roles/configure_bootstrap/files/*.pub
rm -f configure-aws/inventory/*.yml
rm -f configure-aws/vault-password.sec
