class ApplicationController < Sinatra::Base
set :views, Proc.new { File.join(root, "../views/") }
    get '/' do

    erb :index
  end

    get '/signup' do

      erb :signup
    end

    get '/failure' do

      erb :failure
    end

    post '/signup' do
      params.each do |key, param|
        if param.empty?
          redirect '/failure'
        else
          @user = User.create(params)
          redirect '/tweets'
        end
      end
    end



end
