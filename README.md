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

You will need to provide an initializer file with credentials:
```ruby
OpentableApiWrapper.configure do |config|
  config.auth_url = 'https://xxxyyyzz.com'
  config.directory_url = 'https://xxxyyyzz.com'
  config.client_id = 'YOUR_CLIENT_ID'
  config.api_pass = 'YOUR_API_PASSWORD'
end
```

You will need to have a rake task (it's recommended to cron it on a daily basis), to update your local directory:

```ruby
task opentable_update_local_dir: :environment do
  p "#######################################################"
  p "# Calling Opentable to update local restaurants dir.  #"
  p "# Process will execute in background.                 #"
  p "#######################################################"
  OpentableUpdateDirJob.perform_later
end
```

This gem uses two Sidekiq queues which you will need to include in your `sidekiq.yml` file: `ot_save_results` and `default`.

Once you¡ve executed the rake task you will be able to perform queries as follows:

```ruby
OpentableHelpers.restaurants_in_radius(45.000943, -4.23423, 50, force_pics: true)

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/opentable_api_wrapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/opentable_api_wrapper/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OpentableApiWrapper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/opentable_api_wrapper/blob/master/CODE_OF_CONDUCT.md).
