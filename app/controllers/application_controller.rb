class ApplicationController < Sinatra::Base
set :views, Proc.new { File.join(root, "../views/") }
    get '/' do

    erb :index
  end

    get '/signup' do

      erb :signup
    end

    post '/signup' do

      redirect '/'
    end



end
