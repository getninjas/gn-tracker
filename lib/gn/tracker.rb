require "gn/tracker/version"

module Gn
  module Tracker
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
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
