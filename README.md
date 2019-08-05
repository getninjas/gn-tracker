### Installation

```ruby
gem 'gn-tracker'
```

### Configuration

```ruby
require "gn/tracker"

Gn::Tracker.configure do |config|
  config.application = "YourApp"
  config.path = "/var/www/example/shared/logstash"
end
```

### Unstruct Event

Just call `track_unstruct_event` method:

```ruby
require "gn/tracker"

tracker = Gn::Tracker.new
tracker.track_unstruct_event(message: { a: 1 }, schema: "iglu:br.com.example.com/schema/1.0.0")
```

The attributes `message` and `schema` are mandatory. If you want to send an event for a different application, you can specify an `application`:

```ruby
require "gn/tracker"

tracker = Gn::Tracker.new

tracker.track_unstruct_event(
  message: { a: 1 },
  schema: "iglu:br.com.example.com/schema/1.0.0",
  application: "Kituno"
)
```

You can pass the argument `true_timestamp` (in milliseconds):

```ruby
require "gn/tracker"

tracker = Gn::Tracker.new
tracker.track_unstruct_event(
  message: { a: 1 },
  schema: "iglu:br.com.example.com/schema/1.0.0",
  application: "Kituno",
  true_timestamp: "1509471096577"
)
```

and pass the argument `contexts` (array with aditional contexts):

```ruby
require "gn/tracker"

contexts = [
  {
    schema: "iglu:br.com.example.com/another_schema/1.0.0",
    message: { b: 2 }
  },

  {
    schema: "iglu:br.com.example.com/third_schema/1.0.0",
    message: { c: 3 }
  }
]

tracker = Gn::Tracker.new

tracker.track_unstruct_event(
  message: { a: 1 },
  schema: "iglu:br.com.example.com/schema/1.0.0",
  application: "Kituno",
  contexts: contexts
)
```
