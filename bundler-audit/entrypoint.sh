#!/bin/sh

# Exit if any subcommand fails
set -e
cd $GITHUB_WORKSPACE

if [ -f "Gemfile" ]; then
  echo "# Bundling..."
  gem install bundler
  gem sources -a https://"${WORKAREA_GEMSERVER_USERNAME}":"${WORKAREA_GEMSERVER_PASSWORD}"@gems.weblinc.com
  bundle config set --global gems.weblinc.com "${WORKAREA_GEMSERVER_USERNAME}":"${WORKAREA_GEMSERVER_PASSWORD}"
  #bundle install --jobs 4 --retry 3
fi

# Setup bundler-audit if needed
if [ ! `which bundler-audit` ]; then
  echo "\n# Installing bundler-audit..."
  gem install bundler-audit
fi

echo "\n# Running bundler-audit..."
sh -c "bundle audit check --update ${INPUT_ARGS}"
