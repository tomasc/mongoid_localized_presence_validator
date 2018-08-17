# Mongoid Localized Presence Validator

[![Build Status](https://travis-ci.org/tomasc/mongoid_localized_presence_validator.svg)](https://travis-ci.org/tomasc/mongoid_localized_presence_validator) [![Gem Version](https://badge.fury.io/rb/mongoid_localized_presence_validator.svg)](http://badge.fury.io/rb/mongoid_localized_presence_validator) [![Coverage Status](https://img.shields.io/coveralls/tomasc/mongoid_localized_presence_validator.svg)](https://coveralls.io/r/tomasc/mongoid_localized_presence_validator)

This patch of the [mongoid](https://github.com/mongodb/mongoid) presence validator makes it easier to work with localized fields by adding the possibility to selectively validate the presence of certain locales or the app's default locale only.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid_localized_presence_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid_localized_presence_validator

## Usage

```RUBY
class MyDoc
  include Mongoid::Document
  field :some_localized_field, type: String, localize: true

  # Validate the presence of specific locales:
  validates :some_localized_field, presence: %i[cs]

  # Or just the default locale:
  validates :some_localized_field, presence: :default_locale
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mongoid_localized_presence_validator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MongoidLocalizedPresenceValidator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mongoid_localized_presence_validator/blob/master/CODE_OF_CONDUCT.md).
