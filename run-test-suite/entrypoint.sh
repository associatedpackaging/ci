#!/bin/sh

# Exit if any subcommand fails
set -e
cd $GITHUB_WORKSPACE

if [ -f "Gemfile" ]; then
  echo "# Bundling..."
  gem install bundler
  bundle config path vendor/bundle
  bundle install --jobs 4 --retry 3
  yarn install
  bundle exec rake workarea:services:up
  timeout 300 bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:9200)" != "200" ]]; do sleep 1; done' || false
fi

if [ -z "$1" ]; then
  glob="workarea:test"
else
  glob="$@"
fi

echo "\n# Running tests..."
sh -c "bin/rails $glob"
