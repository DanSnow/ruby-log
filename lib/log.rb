#!/usr/bin/env ruby
# encoding: UTF-8

require 'logger'
require 'singleton'
require 'forwardable'

module Log
  private

  module LogMethods
    extend Forwardable
    def_delegators :logger, *::Log::LOG_LEVEL

    def level=(level)
      ::Log::Log.level = Logger.const_get level.to_s.upcase.to_sym
    end

    private

    def logger
      ::Log::Log.instance
    end
  end

  public

  LOG_LEVEL = %i(fatal error warn info debug)
  class Log
    include Singleton
    extend Forwardable
    def_delegators :@logger, *::Log::LOG_LEVEL, :level=

    def initialize
      @logger = Logger.new(STDERR)
    end
  end

  class << self
    include LogMethods
  end

  include LogMethods
end
