#!/bin/bash
set -euo pipefail

yum update -y
amazon-linux-extras install docker -y
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user || true

%{ if harbor_insecure }
mkdir -p /etc/docker
cat >/etc/docker/daemon.json <<EOF
{"insecure-registries":["${harbor_registry}"]}
EOF
systemctl restart docker
%{ endif }

echo '${harbor_password}' | docker login '${harbor_registry}' -u '${harbor_username}' --password-stdin
docker pull '${image_ref}'
docker rm -f dptweb || true
docker run -d --name dptweb --restart always -p 8080:8080 \
  -e SPRING_DATASOURCE_URL='jdbc:mysql://${db_endpoint}/${db_name}' \
  -e SPRING_DATASOURCE_USERNAME='${db_username}' \
  -e SPRING_DATASOURCE_PASSWORD='${db_password}' \
  '${image_ref}'
