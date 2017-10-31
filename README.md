# Gn::Tracker

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/gn/tracker`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gn-tracker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gn-tracker

## Usage

### Configuration

```
require "gn/tracker"

Gn::Tracker.configure do |config|
  config.application = "YourApp" # App name used to identity the event
  config.path = "/var/www/getninjas/shared/logstash" # File which stores some logs
end
```

### Unstruct Event
Just call `track_unstruct_event` method:

```
require "gn/tracker"

tracker = Gn::Tracker.new
tracker.track_unstruct_event(message: { a: 1 }, schema: "iglu:br.com.getninjas.com.br/schema/1.0.0")
```

The attributes `message` and `schema` are mandatory. If you want to send an event for a different application, you can specify an `application`:

```
require "gn/tracker"

tracker = Gn::Tracker.new
tracker.track_unstruct_event(
  message: { a: 1 },
  schema: "iglu:br.com.getninjas.com.br/schema/1.0.0",
  application: "Kituno"
)
```

You can pass the argument `true_timestamp`:

```
require "gn/tracker"

tracker = Gn::Tracker.new
tracker.track_unstruct_event(
  message: { a: 1 },
  schema: "iglu:br.com.getninjas.com.br/schema/1.0.0",
  application: "Kituno",
  true_timestamp: "1509471096577"
)
```

### Struct Event

-TODO: Not implemented yet

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gn-tracker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
