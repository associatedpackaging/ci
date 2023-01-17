#!/bin/sh

# Exit if any subcommand fails
set -e
cd $GITHUB_WORKSPACE

if [ -f "Gemfile" ]; then
  echo "# Bundling..."
  gem install bundler
  gem sources -a https://"${BUNDLE_GEMS__WEBLINC__COM}"@gems.weblinc.com
  #bundle install --jobs 4 --retry 3
fi

# Setup Rubocop if needed
if [ ! `which rubocop` ]; then
  echo "\n# Installing rubocop..."
  gem install nokogiri --version "=1.13.10"
  gem install css_parser --version "=1.12.0"
  gem install rubocop --version "~>0.58.0"
  gem install premailer --version "=1.15.0"
  gem install workarea-ci --version "=3.4.14"
  gem sources -r https://"${BUNDLE_GEMS__WEBLINC__COM}"@gems.weblinc.com
fi

if [ -z "$1" ]; then
  glob="."
else
  glob="$@"
fi

echo "\n# Running Rubocop..."
sh -c "rubocop $glob"
