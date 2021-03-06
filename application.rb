require 'sinatra/base'
require 'bcrypt'
class Application < Sinatra::Application
  enable :sessions

  def initialize(app=nil)
    super(app)
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

  get '/login' do
    erb :login, locals: {errors: nil}
  end

  post '/login' do
    user = DB[:users][email: params[:email]]
    if DB[:users][email: params[:email]].nil? || BCrypt::Password.new(user[:password])!= params[:password]
      erb :login, locals: {errors: "Email / password is invalid"}
    else
      session[:user_id] = user[:id]
      redirect '/'
    end
  end

  get '/show_users' do
    users = DB[:users].to_a
    erb :show_users, locals: {:users => users}
  end

  get '/about' do
    erb :about
  end

  get '/learn' do
    erb :learn
  end

  get '/juices' do
    erb :juices
  end

  get '/order' do
    erb :order
  end

  get '/contact' do
    erb :contact
  end

end