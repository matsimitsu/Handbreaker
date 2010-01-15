require 'FileUtils'
module Handbreaker
  class Watcher
  
    def self.watch
      folders = Handbreaker::config[:folders]
      puts '*** Starting ***'
      trap('TERM') { $exit = true }
      trap('INT')  { $exit = true }
       
      loop do
        entries = Dir[File.expand_path(File.join(folders[:in], "**/*.avi"))]
        entries.each do |entry|
          puts entries.first
          h = Handbreaker::Converter.new(entry)
          h.convert
          puts "Converted: #{File.basename(entry)}"
          FileUtils.rm_rf File.dirname(entry)
        end
        if $exit
          puts '*** Terminating ***'
          break
        end
        sleep 5
      end
    end
  end
end