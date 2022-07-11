# frozen_string_literal: true

require_relative 'opentable_api_wrapper/version'

Dir["#{File.dirname(__FILE__)}/opentable_api_wrapper/**/*.rb"].sort.each do |file|
  require file
end

module OpentableApiWrapper
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :auth_url, :directory_url, :client_id, :api_pass

    def initialize
      @auth_url = nil
      @directory_url = nil
      @client_id = nil
      @api_pass = nil
    end
  end
end
