## README

This repo contains a very simple Rails app to be used for demonstration purposes. The master branch is the work-in-progress version of the final app and other weeks are hosted in other branches.

### To Get Started

* Clone
* To get a specific branch, use `git checkout -b branch_name origin/branch_name`.
* `bundle install --without production`
* `bundle exec rake neo4j:install[community-2.2.0-M02]`
* `bundle exec rake neo4j:start` and give that command a moment to finish.

`rails s` to start the app in the browser, `rails c` to start the Rails console.

When you're done, use `bundle exec rake neo4j:stop` to stop your app.

### Current Branches

`devise-1-base` is the only branch other than master at the moment. `git checkout -b devise-1-base origin/devise-1-base` to get started.
