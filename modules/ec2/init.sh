#!/bin/bash

# Update the system
yum update -y
yum install docker -y

systemctl start docker
systemctl enable docker

# Ecriture du fichier .env pour le conteneur
tee ".env" <<EOF
DB_HOST=${host_env}
DB_NAME=${dbname_env}
DB_USER=${user_env}
DB_PASSWORD=${password_env}
EOF

# Lancement
sudo docker run -d -p 80:80 --name apache-php --env-file .env manukowalsk/terraform_aws_sdv:latest