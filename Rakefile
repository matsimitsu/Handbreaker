require 'rubygems'
require 'rake'
require 'lib/handbreaker'

begin
  namespace :handbreaker do
    
    desc "Run the server"
    task :server do
      Handbreaker::Server.run!
    end
    
    desc "Run the converter"
    task :convert do
      if ENV.include?("source")
        Handbreaker::Converter.new(ENV['source'], ENV.include?("target") ? ENV['target'] : nil).run
      end
    end
    
    desc "Run the watcher"
    task :watch do
      Handbreaker::Watcher.watch
    end
  end
end