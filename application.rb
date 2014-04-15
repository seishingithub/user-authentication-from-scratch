require 'sinatra/base'
require 'bcrypt'
class Application < Sinatra::Application
  enable :sessions

  def initialize(app=nil)
    super(app)

    # initialize any other instance variables for you
    # application below this comment. One example would be repositories
    # to store things in a database.

  end

  get '/' do
    if session[:user_id]
      user_id = session[:user_id]
      user = DB[:users][:id => user_id]
      email = user[:email]
    else
      email = nil
    end
    erb :index, locals: {email: email, user: user}
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    hashed_password = BCrypt::Password.create(params[:password])
    users_table = DB[:users]
    new_id =users_table.insert(email: params[:email], password: hashed_password)
    session[:user_id] = new_id
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end