class ApplicationController < Sinatra::Base
set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "my_little_secret"
  end

    get '/' do

      erb :index
    end

    # get '/users/signup' do
    #   if Helpers.logged_in?(session)
    #     redirect '/tweets/tweets'
    #   else
    #     erb :'/users/signup'
    #   end
    # end

    # get '/users/login' do
    #   if Helpers.logged_in?(session)
    #     redirect 'tweets/tweets'
    #   else
    #     erb :'/users/login'
    #   end
    # end

    get 'tweets/new' do
      if Helpers.logged_in?(session)
        binding.pry
        erb :index
      else
        redirect '/users/login'
      end
    end

    # get '/user/:slug' do
    #   binding.pry
    #    erb :show
    # end

   get '/tweets/tweets' do
     if Helpers.logged_in?(session)
       @user = User.find(session[:user_id])
       @tweets = Tweet.all
      erb :'/tweets/tweets'
     else
       redirect '/users/login'
     end
  end

    # get "/tweets/:id" do
    #   @user = User.find_by_slug(params[:slug])
    #   @tweets = @user.tweets
    #
    #   erb :show
    # end

    # get '/show/:user' do
    #   Helpers.current_user(session)
    #
    #   erb :show
    # end




    # get "/users/:slug" do
    #   @user = User.find_by_slug(params[:slug])
    #   @tweets = @user.tweets
    #   erb :show
    # end




end
