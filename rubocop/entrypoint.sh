#!/bin/sh

# Exit if any subcommand fails
set -e
cd $GITHUB_WORKSPACE

if [ -f "Gemfile" ]; then
  echo "# Bundling..."
  gem install bundler
  gem sources -a https://"${WORKAREA_GEMSERVER_USERNAME}":"${WORKAREA_GEMSERVER_PASSWORD}"@gems.weblinc.com
  bundle config set --global gems.weblinc.com "${WORKAREA_GEMSERVER_USERNAME}":"${WORKAREA_GEMSERVER_PASSWORD}"
  bundle install --jobs 4 --retry 3
fi

# Setup Rubocop if needed
if [ ! `which rubocop` ]; then
  echo "\n# Installing rubocop..."
  gem install rubocop
fi

if [ -z "$1" ]; then
  glob="."
else
  glob="$@"
fi

echo "\n# Running Rubocop..."
sh -c "rubocop $glob"
