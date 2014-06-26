path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class Galvino < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  get "/" do
    haml :index
  end

  post "/" do
    INO.digital_write 2, true
    sleep 4
    INO.digital_write 2, false
  end
end

require_all "#{path}/routes"