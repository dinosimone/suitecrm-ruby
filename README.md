# SuiteCRM::Ruby

Ruby API client for SuiteCRM V8

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'suitecrm-ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install suitecrm-ruby

## Usage

### Configuration

Prior to using the API client, you will need to create a new API user as documented here [https://docs.suitecrm.com/developer/api/developer-setup-guide/configure-authentication/].

```ruby
SuiteCRM.configure do |config|
  config.api_url = "http://[ip]/suite/Api/V8"
  config.token_url = "http://[ip]/suite/Api/access_token"
  config.client_id = "[client id]"
  config.client_secret = "[client secret]"
end
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/suitecrm-ruby.

