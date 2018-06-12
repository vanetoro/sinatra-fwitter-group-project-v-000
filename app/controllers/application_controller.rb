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
        @tweets = @user.tweets
       erb :tweets
      else
        redirect '/login'
      end
   end

    get "/tweets/:id" do
      binding.pry
      @user = User.find_by_slug(params[:slug])
      @tweets = @user.tweets

      erb :show
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



    get '/login' do

      erb :login
    end

    get '/tweets' do
      if !!session[:user_id]
        @user = User.find(session[:user_id])
        binding.pry
        @tweets = @user.tweets
       erb :tweets
      else
        redirect '/login'
      end
   end

    post '/login' do
      binding.pry
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

    get '/logout' do
      session.clear
      redirect '/login'
    end
end
