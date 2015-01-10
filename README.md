## README

This repo contains a very simple Rails app to be used for demonstration purposes.

### To Get Started

* Clone
* `bundle install --without production`
* `bundle exec rake neo4j:install[community-2.2.0-M02]`
* `bundle exec rake neo4j:start` and give that command a moment to finish.

Start the app as you would normally.

When you're done, use `bundle exec rake neo4j:stop` to stop your app.
