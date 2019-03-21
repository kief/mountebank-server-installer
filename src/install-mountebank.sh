#!/bin/sh

set -e -x

cd /tmp
curl -sSL -o mountebank_2.0.0_amd64.deb "https://s3.amazonaws.com/mountebank/v2.0/mountebank_2.0.0_amd64.deb"
dpkg -i mountebank_2.0.0_amd64.deb

# # create mountebank_user group
#       group:
#         name: "{{ mountebank_user }}"
#         state: present

# # create mountebank_user
#       user:
#         name: "{{ mountebank_user }}"
#         group: "{{ mountebank_user }}"
#         system: yes

# # Install mountebank
#       yum:
#         name: https://s3.amazonaws.com/mountebank/v1.12/mountebank-1.12.0-1.x86_64.rpm

# # Create mountebank log directory
#       file:
#         path: /var/log/mountebank
#         state: directory
#         owner: "{{ mountebank_user }}"
#         group: "{{ mountebank_user }}"
#         mode: 0755

# # Install mountebank service config file
#       template:
#         src: templates/mountebank.service.j2
#         dest: /usr/lib/systemd/system/mountebank.service
#         mode: 0644
#         owner: root
#         group: root

#     # reload because we changed mountebank.service files
# # Reload daemon configs 
#       command: systemctl daemon-reload

# # Start mountebank service
#       service:
#         name: mountebank
#         state: started
#         enabled: yes
