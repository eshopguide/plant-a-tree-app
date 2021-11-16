web:  bin/rails server -p $PORT -e $RAILS_ENV
jobworker: bundle exec sidekiq -q default -c 5
release: bundle exec rake db:migrate
