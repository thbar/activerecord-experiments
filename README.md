Create `db/config.yml` based on 'db/config.yml.sample' then run:

```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake spec
```