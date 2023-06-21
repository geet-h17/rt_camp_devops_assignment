#!/bin/bash

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install missing packages
install_packages() {
  if ! command_exists docker; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker "$USER"
    echo "Docker installed successfully!"
  fi

  if ! command_exists docker-compose; then
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose installed successfully!"
  fi
}

# Function to create a WordPress site
create_site() {
  if [[ -z "$1" ]]; then
    echo "Please provide a site name as a command-line argument."
    exit 1
  fi

  site_name="$1"
  echo "Creating WordPress site: $site_name"

  mkdir "$site_name"
  cd "$site_name"

  cat >docker-compose.yml <<EOF
version: '3'
services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
  wordpress:
    depends_on:
      - db
    image: wordpress
    volumes:
      - ./wp:/var/www/html
    ports:
      - "8080:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    extra_hosts:
      - "$site_name:127.0.0.1"
volumes:
  db_data: {}
EOF

  echo "Site created successfully!"
}

# Function to start the site
start_site() {
  if [[ -z "$1" ]]; then
    echo "Please provide a site name as a command-line argument."
    exit 1
  fi

  site_name="$1"
  echo "Starting the $site_name site..."

  cd "$site_name" || exit 1

  docker-compose up -d

  echo "Site started successfully!"
}

# Function to stop the site
stop_site() {
  if [[ -z "$1" ]]; then
    echo "Please provide a site name as a command-line argument."
    exit 1
  fi

  site_name="$1"
  echo "Stopping the $site_name site..."

  cd "$site_name" || exit 1

  docker-compose down

  echo "Site stopped successfully!"
}

# Function to delete the site
delete_site() {
  if [[ -z "$1" ]]; then
    echo "Please provide a site name as a command-line argument."
    exit 1
  fi

  site_name="$1"
  echo "Deleting site: $site_name"

  cd "$site_name" || exit 1

  docker-compose down -v
  cd ..
  rm -rf "$site_name"

  echo "Site deleted successfully!"
}

# Function to check if the site is up and healthy
check_site_health() {
  site_name="$1"
  echo "Checking site health: $site_name"

  response=$(curl -sL -w "%{http_code}" "http://$site_name" -o /dev/null)
  if [[ "$response" == "200" ]]; then
    echo "Site is up and healthy!"
    xdg-open "http://$site_name" >/dev/null 2>&1
  else
    echo "Site is not responding as expected. Please check manually."
  fi
}

# Parse command-line arguments
command="$1"

case "$command" in
  create)
    site_name="$2"
    create_site "$site_name"
    check_site_health "$site_name"
    ;;
  start)
    site_name="$2"
    start_site "$site_name"
    ;;
  stop)
    site_name="$2"
    stop_site "$site_name"
    ;;
  delete)
    site_name="$2"
    delete_site "$site_name"
    ;;
  *)
    echo "Usage: ./script.sh create <site_name> | start <site_name> | stop <site_name> | delete <site_name>"
    exit 1
    ;;
esac

