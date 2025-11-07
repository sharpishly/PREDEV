#!/bin/bash
set -e

echo "🔍 Running pre-check for databases and users..."

# PostgreSQL settings (match docker-compose)
PGHOST="localhost"
PGUSER="postgres"
PGPASSWORD="admin12345"
PGDATABASE="postgres"
TARGET_DB="sharpishly_db"
TARGET_USER="sharpishly_user"
TARGET_PASS="admin12345"

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be available..."
until docker exec app-postgres-1 pg_isready -U "$PGUSER" >/dev/null 2>&1; do
  sleep 2
done
echo "✅ PostgreSQL is ready."

# Check if the user exists
USER_EXISTS=$(docker exec -e PGPASSWORD="$PGPASSWORD" app-postgres-1 psql -U "$PGUSER" -tAc "SELECT 1 FROM pg_roles WHERE rolname='$TARGET_USER';")
if [ "$USER_EXISTS" != "1" ]; then
  echo "👤 User $TARGET_USER not found. Creating..."
  docker exec -e PGPASSWORD="$PGPASSWORD" app-postgres-1 psql -U "$PGUSER" -c "CREATE USER $TARGET_USER WITH PASSWORD '$TARGET_PASS';"
else
  echo "✅ User $TARGET_USER already exists."
fi

# Check if the database exists
DB_EXISTS=$(docker exec -e PGPASSWORD="$PGPASSWORD" app-postgres-1 psql -U "$PGUSER" -tAc "SELECT 1 FROM pg_database WHERE datname='$TARGET_DB';")
if [ "$DB_EXISTS" != "1" ]; then
  echo "🗃️ Database $TARGET_DB not found. Creating..."
  docker exec -e PGPASSWORD="$PGPASSWORD" app-postgres-1 psql -U "$PGUSER" -c "CREATE DATABASE $TARGET_DB OWNER $TARGET_USER;"
else
  echo "✅ Database $TARGET_DB already exists."
fi

echo "🎉 Pre-check completed successfully."
