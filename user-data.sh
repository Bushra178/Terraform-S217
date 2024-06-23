#!/bin/bash
# Sleep for 1 minute to ensure the instance is fully up and running
sleep 120

# Redirect all output to a log file
exec > /var/log/user-data.log 2>&1

# Update the package index
yum update -y

# Install Docker
yum install -y docker

# Start Docker service
systemctl start docker

# Enable Docker to start on boot
systemctl enable docker

# Add the ec2-user to the docker group
usermod -aG docker ec2-user

#check docker version
docker --version

echo "Docker installed successfully!!!!"

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the Docker Compose binary
chmod +x /usr/local/bin/docker-compose

# Install glibc and libxcrypt-compat libraries
yum install -y glibc glibc-common
yum install -y libxcrypt-compat

# Verify Docker Compose installation
docker-compose --version

echo "docker-compose installed successfully!!!!!!"

# Create docker-compose.yaml file
cat <<EOL > /home/ec2-user/docker-compose.yaml
version: '2'
services:
  mariadb:
    image: docker.io/bitnami/mariadb:11.3
    volumes:
      - 'mariadb_data:/bitnami/mariadb'
    environment:
      # ALLOW_EMPTY_PASSWORD is recommended only for development.
      - ALLOW_EMPTY_PASSWORD=yes
      - MARIADB_USER=bn_wordpress
      - MARIADB_DATABASE=bitnami_wordpress
  wordpress:
    image: docker.io/bitnami/wordpress:6
    ports:
      - '80:8080'
      - '443:8443'
    volumes:
      - 'wordpress_data:/bitnami/wordpress'
    depends_on:
      - mariadb
    environment:
      # ALLOW_EMPTY_PASSWORD is recommended only for development.
      - ALLOW_EMPTY_PASSWORD=yes
      - WORDPRESS_DATABASE_HOST=mariadb
      - WORDPRESS_DATABASE_PORT_NUMBER=3306
      - WORDPRESS_DATABASE_USER=bn_wordpress
      - WORDPRESS_DATABASE_NAME=bitnami_wordpress
volumes:
  mariadb_data:
    driver: local
  wordpress_data:
    driver: local
EOL

# Navigate to home directory and run docker-compose
cd /home/ec2-user

#run docker-compose file
docker-compose up -d

echo "script executed successfully!!!!!"
