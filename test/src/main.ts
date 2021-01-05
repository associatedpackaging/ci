import * as core from '@actions/core';
const { execSync } = require('child_process');

async function run() {
  try {
    execSync("gem install bundler", { stdio: 'inherit' });
    execSync("bundle install --jobs 4 --retry 3", { stdio: 'inherit' });
    execSync("bundle exec $(bundle exec rake -T | grep services:up | sed 's/\\w*#.*//')", { stdio: 'inherit' });
    execSync(`timeout 300 bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:9200)" != "200" ]]; do sleep 1; done' || false`, { stdio: 'inherit' });
    execSync(core.getInput('command'), { env: Object.assign(process.env, { CI: true }), stdio: 'inherit' });

  } catch (error) {
    core.setFailed(error);
  }
}

run();
