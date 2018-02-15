web: bundle exec puma --config ./config/puma.rb
worker: bundle exec sidekiq -t 25 -q default -q mailers
webpack: yarn run js:watch
clockwork: bundle exec clockwork ./app/jobs/clockwork.rb
