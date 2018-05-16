require "gn/tracker/version"
require "logstash-logger"

module Gn
  class Tracker
    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end
    end

    def self.configure
      yield(configuration)
    end

    def initialize
      @logger = LogStashLogger.new(
        type: :file,
        sync: true,
        path: self.class.configuration.path
      )
    end

    def track_unstruct_event(
      message:,
      schema:,
      application: self.class.configuration.application,
      true_timestamp: DateTime.now.strftime('%Q'),
      context: []
    )
      event = LogStash::Event.new(
        message: message.to_json,
        application: application,
        schema: schema,
        true_timestamp: true_timestamp,
        context: context.to_json
      )
      @logger.info event
    end

    class Configuration
      attr_accessor :application, :path

      def initialize
        @application, @path = 'GetNinjas', '/tmp/logstash'
      end
    end
  end
end
