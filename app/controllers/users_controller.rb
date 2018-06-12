class UsersController < Sinatra::Base
set :views, Proc.new { File.join(root, "../views/users") }

  configure do
    enable :sessions
    set :session_secret, "my_little_secret"
  end

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/tweets/tweets'
    else
      erb :signup
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      binding.pry
      redirect :'/tweets/tweets'
    else
      erb :login
    end
  end

# works
  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '../tweets/tweets'
    end

    post '/users/login' do
      @user = User.find_by(username: params[:username])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id

        redirect '/tweets'
      else
        redirect '/users/login'
      end
    end

    get '/logout' do
      session.clear
      redirect '/login'
    end

  end


end
