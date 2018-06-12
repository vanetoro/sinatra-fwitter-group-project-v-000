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

  #  get '/new' do
  #    if Helpers.logged_in?(session)
  #      binding.pry
  #        erb :create_tweet
  #    else
  #      redirect '/login'
  #    end
  #  end

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



    # get '/user/:slug' do
    #   binding.pry
    #    erb :show
    # end



    # get "/tweets/:id" do
    #   @user = User.find_by_slug(params[:slug])
    #   @tweets = @user.tweets
    #
    #   erb :show
    # end






    # get "/users/:slug" do
    #   @user = User.find_by_slug(params[:slug])
    #   @tweets = @user.tweets
    #   erb :show
    # end
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

          redirect :'/tweets/tweets'
      else
        erb :'/users/login'
      end
    end

    # works
    post '/signup' do
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect '/signup'
      else
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect '/tweets/tweets'
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

      get '/:user/show' do
        binding.pry
        if Helpers.current_user(session)
          @user = User.find_by_slug(params[:user])
          erb :show
        else
          redirect '/login'
        end
      end

      get '/logout' do
        session.clear
        redirect '/login'
      end


end
