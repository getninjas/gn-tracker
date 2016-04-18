require "gn/tracker/version"

module Gn
  module Tracker
    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end
    end

    def self.configure
      yield(configuration)
    end

    class Configuration
      attr_accessor :application

      def initialize
        @application = 'GetNinjas'
      end
    end
  end
end
