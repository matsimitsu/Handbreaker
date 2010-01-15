module Handbreaker
  class Converter
    attr_accessor :input, :output, :folders, :handbreaker_bin, :temp_output
  
    def initialize(input, output = nil)
      self.folders = Handbreaker::config[:folders]
      self.handbreaker_bin = Handbreaker::config[:handbrake][:path]
      self.input = File.expand_path(input)
      self.temp_output = File.expand_path(File.join(self.folders[:out], "#{ output ? output : File.basename(input) }.temp"))
      self.output = File.expand_path(File.join(self.folders[:out], "#{ output ? output : File.basename(input) }.temp"))
    end
  
    def convert
      item_options = {
        :input   => self.input,
        :output  => self.temp_output,
        :preset  => "iPhone & iPod Touch",
      }.map {|k,v| "--#{k} #{v.inspect}" }.join(' ')

      execute "#{self.handbreaker_bin} #{item_options}"
      File.rename(self.temp_output, self.output)
    end
  private

    def execute command
      5.times { puts }
      puts 'Starting!'
      puts

      IO.popen(command) do |output|
        begin
          puts line while line = output.gets
        rescue
          puts 'Finished!'
        end
      end

      5.times { puts }
    end
  end
end
