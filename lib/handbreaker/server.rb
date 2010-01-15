require 'rubygems'
require 'sinatra/base'
require 'builder'

module Handbreaker
  class Server < Sinatra::Base
    
    set :server, %w[thin mongrel webrick]
    set :environment, Handbreaker::config[:server][:environment]
    set :port, Handbreaker::config[:server][:port]
    set :host, Handbreaker::config[:server][:host]
    
    get '/' do
      folders = Handbreaker::config[:folders]
      @folder = Dir[File.expand_path(File.join(folders[:out], "*.mp4"))]
      content_type 'application/xml', :charset => 'utf-8'
      builder :index
    end

    get '/files/:file' do
      folders = Handbreaker::config[:folders]
      puts File.expand_path(File.join(folders[:out], params[:file]))
      send_file File.expand_path(File.join(folders[:out], params[:file])), {:filename=>params[:file]}
    end
  end
end