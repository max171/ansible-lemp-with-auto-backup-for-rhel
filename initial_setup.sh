#!/bin/sh
dnf install -y sudo git ansible-core
alias ll="ls -l"
adduser nginx
cd /home/nginx/
mkdir .ssh /srv/git/ /srv/http/ && chmod 700 .ssh 
touch .ssh/id_rsa .ssh/config && chmod 600 .ssh/id_rsa .ssh/config
chown -R nginx:nginx .ssh /srv/ /srv/git /srv/http/
echo "StrictHostKeyChecking=accept-new" > .ssh/config
cd /srv/git/
sudo -u nginx bash << EOF
git clone git@github.com:max171/ansible-lemp-with-auto-backup-for-rhel.git
EOF
rm -f .ssh/config
ansible-galaxy install -r /srv/git/ansible-lemp-with-auto-backup-for-rhel/requirements.yml
ansible-playbook -v /srv/git/ansible-lemp-with-auto-backup-for-rhel/configure_server.yml --extra-vars "env=development"