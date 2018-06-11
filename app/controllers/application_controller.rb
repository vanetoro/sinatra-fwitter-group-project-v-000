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

      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      # create(params)
      binding.pry
        if @user.save
         redirect '/tweets'
       else
         redirect '/failure'
       end
      # params.each do |key, param|
      #   if param.empty?
      #     redirect '/failure'
      #   else
      #     @user = User.create(params)
      #     redirect '/tweets'
      #   end
      end




end
