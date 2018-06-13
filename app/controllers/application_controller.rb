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
     if Helpers.logged_in?(session)
       @tweet = Tweet.find(params[:id])
       erb :'/tweets/show_tweet'
     else
       redirect '/users/login'
     end
   end

   get "/tweets/:id/edit" do
     if Helpers.logged_in?(session) && Helpers.current_user(session)
       @tweet = Tweet.find(params[:id])
       erb :'/tweets/edit_tweet'
     else
       redirect '/users/login'
     end
   end



  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    binding.pry
    @user = @tweet.user
    @tweet.content  = params[:content]
    @tweet.save
    redirect "/users/:slug"
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
        if !params[:content].empty?
          @tweet = Tweet.create(content: params[:content])
          @user.tweets << @tweet
          @user.save
          redirect "/users/#{@user.slug}"
        else
          redirect '/tweets/new'
        end
      end



      get '/logout' do
        session.clear
        redirect '/login'
      end


end
