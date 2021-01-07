import * as core from '@actions/core';
const { execSync } = require('child_process');

async function run() {
  try {
    let command = ['bin/rails workarea:test'];
    let testSuite = core.getInput('test');
    if (testSuite) {
      command.push(testSuite);
    }
    execSync("bundle install --jobs 4 --retry 3", { stdio: 'inherit' });  
    execSync("yarn install", { stdio: 'inherit' });
    execSync(`timeout 300 bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:9200)" != "200" ]]; do sleep 1; done' || false`, { stdio: 'inherit' });
    execSync(command.join(':'), { env: Object.assign(process.env, { CI: true }), stdio: 'inherit' });
  } catch (error) {
    core.setFailed(error);
  }
}

run();
