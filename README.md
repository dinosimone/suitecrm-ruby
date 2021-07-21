# SuiteCRM::Ruby

Ruby client for [SuiteCRM's](https://suitecrm.com/) V8 API

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

Prior to using the API client, you will need to create a new API user as documented [here](https://docs.suitecrm.com/developer/api/developer-setup-guide/configure-authentication).

```ruby
SuiteCRM.configure do |config|
  config.api_url = "http://[ip]/suite/Api/V8"
  config.token_url = "http://[ip]/suite/Api/access_token"
  config.client_id = "[client id]"
  config.client_secret = "[client secret]"
end
```

### Modules

#### Get all module records

```ruby
SuiteCRM::Modules.get("Contacts")
```

#### Get a single module record

```ruby
SuiteCRM::Module.get("Contacts", "51f7baeb-fe82-d3c1-5ef9-60c0de2c67cf")
```

#### Create a new module record

```ruby
SuiteCRM::Module.create(
  data: {
    type: "FP_events",
    attributes: {
      name: "Meeting"
    }
  }
)
```

#### Update a single module record

```ruby
SuiteCRM::Module.update({
  data: {
    type: "Contacts",
    id: "79a08232-6e62-dbaf-af6d-60f7146d1e87",
    attributes: {
      first_name: "Jordan",
      last_name: "Peterson"
    }
  }
})
```

#### Delete a single module record

```ruby
SuiteCRM::Module.delete("Contacts", "79a08232-6e62-dbaf-af6d-60f7146d1e87")
```

### Relationships

#### Get all relationships of type for a module

```ruby
SuiteCRM::Relationship.get(
  "Contacts", "669d86ed-e5a3-7605-0d68-60c22f69743a", "fp_events_contacts"
)
```

#### Create a new relationship of type for a module

```ruby
SuiteCRM::Relationship.create(
  "Contacts",
  "669d86ed-e5a3-7605-0d68-60c22f69743a",
  {
    data: {
      type: "FP_events",
      id: "66ef1d43-06a9-5c09-0853-60f0707fad32"
    }
  }
)
```

#### Delete a single module relationship

```ruby
SuiteCRM::Relationship.delete(
  "Contacts",
  "669d86ed-e5a3-7605-0d68-60c22f69743a",
  "fp_events_contacts",
  "66ef1d43-06a9-5c09-0853-60f0707fad32"
)
```

### Meta

#### Obtain a list of available modules

```ruby
SuiteCRM::Meta.get
```

## Testing

In developement, run the app using

    $ rspec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dinosimone/suitecrm-ruby.

