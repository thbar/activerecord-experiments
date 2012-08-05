This repository is a playground around various ways to handle prices with ActiveRecord.

## Already implemented

#### DecimalPriceProduct

Uses a decimal column to implement the price attribute.

Issue: `price_before_type_cast` will equal `nil` even if you pass a blank string, so you cannot rely on `price_before_type_cast` to provide a different treatment to a blank input if needed.

Links:

- https://github.com/rails/rails/blob/4bbd05c90e5a62c0316307b3ca7c2262ed98b567/activemodel/lib/active_model/validations/numericality.rb#L95

## To be implemented

* composed_of (which was removed, then is back for now)
* custom accessors as advised on the commit that first removed composed_of
* money-rails (which implements a certain version of custom accessor)

## How to run

Create `db/config.yml` based on 'db/config.yml.sample' then run:

```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake spec
```