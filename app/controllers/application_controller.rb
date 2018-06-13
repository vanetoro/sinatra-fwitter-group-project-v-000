class ApplicationController < Sinatra::Base
set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "my_little_secret"
  end

    get '/' do

      erb :index
    end

#------- Tweet Controls ------------#
    get '/tweets' do
      if Helpers.logged_in?(session)
        @user = User.find(session[:user_id])
        @tweets = Tweet.all
         erb :'/tweets/tweets'
      else
        redirect '/users/login'
      end
   end

   get '/tweets/new' do
     if Helpers.logged_in?(session)
       @user = User.find(session[:user_id])
       erb :'/tweets/create_tweet'
     else
       redirect '/users/login'
     end
   end

   get "/tweets/:id" do
       @tweet = Tweet.find(params[:id])

     erb :'/tweets/show_tweet'
   end





#---- Users Controls ------------#
    get '/signup' do
      if Helpers.logged_in?(session)
        redirect '/tweets'
      else
        erb :'/users/signup'
      end
    end

    get '/login' do
      if Helpers.logged_in?(session)

          redirect :'/tweets/tweet'
      else
        erb :'/users/login'
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

      post '/login' do
        @user = User.find_by(username: params[:username])
        if @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect '/tweets'
        else
          redirect '/users/login'
        end
      end


      get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        @tweets = @user.tweets

          erb :"/users/show"
      end

      post "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        @tweet = Tweet.create(content: params[:content])
        @tweet.user = @user
        @user.save
        redirect "/users/show"
      end



      get '/logout' do
        session.clear
        redirect '/login'
      end


end
