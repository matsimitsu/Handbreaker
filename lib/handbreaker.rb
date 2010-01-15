require 'rubygems'

module Handbreaker

  attr_accessor :config
  def self.config
    @config ||= YAML::load(File.open("config/config.yml"))
  end
  
end

require 'lib/handbreaker/converter'
require 'lib/handbreaker/server'
require 'lib/handbreaker/watcher'
