#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Precompile assets
bundle exec rails assets:precompile RAILS_ENV=production
bundle exec rails assets:clean RAILS_ENV=production

# Database migration
bundle exec rails db:migrate RAILS_ENV=production

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"