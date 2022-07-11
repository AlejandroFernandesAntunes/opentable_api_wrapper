# OpentableApiWrapper

This gem allows you to interact wit the Opentable API in a very simple way.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'opentable_api_wrapper'
```

And then execute:
```
$ bundle install
$ bundle exec rails generate opentable_api_wrapper:install
$ rake db:migrate
```
    

## Usage

Opentable's directoy API provides a complete set of restaurants that accept online reservations via OpenTable per country. 

The restaurant data is refreshed nightly, so it is recommended to call the API at least once a day to get the most current restaurant directory data.

All results will be stored in the `open_table_restaurants` table, records will be updated if they already exist considering `aux_composed_id` as its uniq identifier.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/opentable_api_wrapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/opentable_api_wrapper/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OpentableApiWrapper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/opentable_api_wrapper/blob/master/CODE_OF_CONDUCT.md).
