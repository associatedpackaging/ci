import * as core from '@actions/core';
const { execSync } = require('child_process');

async function run() {
  try {
    execSync("curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -", { stdio: 'inherit' });
    execSync("echo \"deb https://dl.yarnpkg.com/debian/ stable main\" | sudo tee /etc/apt/sources.list.d/yarn.list", { stdio: 'inherit' });
    execSync("sudo apt update && sudo apt install -y -qq yarn", { stdio: 'inherit' });
    execSync("gem install bundler", { stdio: 'inherit' });
    execSync("bundle install --jobs 4 --retry 3", { stdio: 'inherit' });  
    execSync("yarn install", { stdio: 'inherit' });
    execSync("bundle exec rake workarea:services:up", { stdio: 'inherit' });
    execSync(`timeout 300 bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:9200)" != "200" ]]; do sleep 1; done' || false`, { stdio: 'inherit' });
    execSync(core.getInput('command'), { env: Object.assign(process.env, { CI: true }), stdio: 'inherit' });

  } catch (error) {
    core.setFailed(error);
  }
}

run();
