# Collective access Docker Image

Make an easy deploy of collective access with a Dockerfile or trough Docker Compose. This deploy uses Redis as cache.

## Instructions

1. Make an `.env` file out of `.env-example` and type your credentials.
2. Edit `setup.php` to configure collective access as you wish. Pawtucket and providence need to share the same exact configuration.
3. Edit `init.sql` for the MySQL database. This script creates the necessary user, password, and database. These things must match with your `.env` file
4. Type ['localhost:80/ca']('http://localhost:80/ca') to access to the providence backend.
5. Type ['localhost:80/pawtucket']('http://localhost:80/pawtucket') to access to the pawtucket frontend.
