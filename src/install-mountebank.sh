#!/bin/sh

set -e -x

useradd --user-group --system mountebank

curl -sSL -o /tmp/mountebank_2.0.0_amd64.deb "https://s3.amazonaws.com/mountebank/v2.0/mountebank_2.0.0_amd64.deb"
dpkg -i /tmp/mountebank_2.0.0_amd64.deb
rm /tmp/mountebank_2.0.0_amd64.deb

mkdir -p --mode=0755 /var/log/mountebank
chown mountebank:mountebank /var/log/mountebank

# cat << EOF > /usr/lib/systemd/system/mountebank.service
# [Unit]
# Description=Mountebank mocking service
# Documentation=https://mbtest.org
# After=network.target firewalld.service

# [Service]
# Type=simple
# User=mountebank
# # default mountebank install puts it in /usr/local/bin/
# ExecStart=/usr/local/bin/mb --port 2525 --logfile /var/log/mountebank/mountebank.log
# ExecReload=/usr/local/bin/mb restart
# ExecStop=/usr/local/bin/mb stop
# WorkingDirectory=/var/log/mountebank
# TimeoutStartSec=0
# # kill all of the processes in the cgroup started by mountebank
# KillMode=control-group
# Restart=on-failure
# RestartSec=60

# [Install]
# WantedBy=multi-user.target
# EOF

# chmod 0644 /usr/lib/systemd/system/mountebank.service

# systemctl daemon-reload
# systemctl enable mountebank
# systemctl start mountebank

cd /var/log/mountebank
nohup su mountebank -c '/usr/local/bin/mb --port 2525 --logfile /var/log/mountebank/mountebank.log &'

apt-get install -y netcat
timeout 20 sh -c 'until nc -z localhost 2525; do sleep 1; done'

RESPONSE=${1}

cat > /tmp/imposter.json <<-END_IMPOSTER
{
  "port": 8080,
  "protocol": "http",
  "stubs": [
    {
      "responses": [
        {
          "is": {
            "statusCode": 200,
            "body": {
              "whoami": "${RESPONSE}"
            }
          }
        }
      ]
    }
  ]
}
END_IMPOSTER

curl -sS \
  --header "Content-Type: application/json" \
  --header "Accept: application/json" \
  --request POST \
  -d @/tmp/imposter.json \
  "http://localhost:2525/imposters"
