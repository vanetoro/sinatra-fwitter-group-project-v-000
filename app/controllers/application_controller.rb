class ApplicationController < Sinatra::Base
set :views, Proc.new { File.join(root, "../views/") }


  configure do
    enable :sessions
    set :session_secret, "my_little_secret"
  end

    get '/' do

      erb :index
    end

    get '/signup' do
      if !!session[:user_id]
        redirect '/tweets'
      else
        erb :signup
      end
    end

    get '/login' do
      if !!session[:user_id]
        redirect '/tweets'
      else
        erb :login
      end
    end

    get '/tweets' do
      if !!session[:user_id]
        @user = User.find(session[:user_id])
       erb :tweets
      else
        redirect '/login'
      end
   end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id

        redirect '/tweets'
      else
        redirect '/login'
      end
    end

    post '/signup' do
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect '/signup'
      else
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect '/tweets'
      end
    end

    post '/logout' do
      session.clear
      redirect '/login'
    end
end
