#!/bin/bash
#
#  Usage: run script to initiate ansible run
#         set test as $1 to run tests
#
cd /vagrant

pip -q install -r requirements.txt

PLAYBOOK=${PLAYBOOK:-audit.yml}
SSH_KEY="/home/vagrant/.ssh/vagrant.key"
INVENTORY=/vagrant/hosts.ini

# Disable host key checks for SSH
export ANSIBLE_HOST_KEY_CHECKING=False

deploy() {
  ansible-playbook -i $INVENTORY -M /vagrant --private-key=$SSH_KEY $PLAYBOOK
  if [ $? != 0 ]; then
    echo "Ansible run failed!"
    exit 1
  fi
}

deploy
