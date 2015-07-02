# Mycha Developer Documentation

#### Setup the development environment
* install Node.JS
* `npm install`


#### Run tests
* run all tests and linters: `npm test`
* run only unit tests: `npm run unit-tests`
* run only integration tests: `npm run feature-tests`


#### Update dependencies
* check whether updates are available: `npm run update-check`
* automatically update all dependencies to the latest version: `npm run update`


#### Release a new version

* [update the dependencies](#update-dependencies) to the latest version

```
npm version <patch|minor|major>
npm publish
```
