
class TweetsController < Sinatra::Base
set :views, Proc.new { File.join(root, "../views/users") }

  configure do
    enable :sessions
    set :session_secret, "my_little_secret"
  end

  get '/tweets' do
    if Helpers.logged_in?(session)
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
     erb :tweets
    else
      redirect '/users/login'
    end
 end

get '/new' do
  if Helpers.logged_in?(session)
    binding.pry
    erb :index
  else
    redirect '/users/login'
  end
end


end
