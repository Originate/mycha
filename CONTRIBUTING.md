# Mycha Developer Documentation

#### Setup the development environment
* install Node.JS
* install [Yarn](https://yarnpkg.com/)
* `yarn install`


#### Run tests
* run all tests and linters: `yarn test`
* run only unit tests: `yarn run unit-tests`
* run only integration tests: `yarn run feature-tests`


#### Update dependencies
* check whether updates are available: `yarn run update-check`
* automatically update all dependencies to the latest version: `yarn run update`


#### Release a new version

* [update the dependencies](#update-dependencies) to the latest version

```
yarn version
# push up changes, CI will publish
```
