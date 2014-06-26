class Galvino < Sinatra::Base
  get "/" do
    haml :index
  end
end