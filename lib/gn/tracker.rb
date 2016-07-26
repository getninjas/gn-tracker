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
        type: self.class.configuration.type,
        path: self.class.configuration.path,
        sync: true
      )
    end

    def track_unstruct_event(message:, schema:, application: self.class.configuration.application)
      @logger.info LogStash::Event.new(
        message: message.to_json,
        application: application,
        schema: schema
      )
    end

    class Configuration
      attr_accessor :application, :path

      def initialize
        @application, @path = 'GetNinjas', :file, '/tmp/logstash'
      end
    end
  end
end
