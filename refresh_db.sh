#!/bin/bash

# Salir si ocurre algún error
set -e

# Delete DB
echo "Dropping the database..."
rails db:drop

# Create DB
echo "Creating the database..."
rails db:create

# Migrate DB
echo "Migrating the database..."
rails db:migrate

# Seed DB
echo "Seeding db..."
rails db:seed

echo "Database has been reset and migrated successfully!"
