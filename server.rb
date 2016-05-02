module Sinatra
  require "bcrypt"
  class Server < Sinatra::Base
    enable :sessions

    def current_user
      @current_user ||= db.exec_params(
       "SELECT * FROM users WHERE id=$1 LIMIT 1",
       [session[:user_id]]
     ).first
    end

    def logged_in?
      current_user
    end

    def db
      if ENV["RACK_ENV"] == "production"
        PG.connect(
          dbname: ENV["POSTGRES_DB"],
          host: ENV["POSTGRES_HOST"],
          password: ENV["POSTGRES_PASS"],
          user: ENV["POSTGRES_USER"]
        )
      else
        PG.connect(dbname: "ss_overflow_db")
      end
    end

    get "/" do
      if logged_in?
        erb :posts
      else
        erb :index
      end
    end

    post "/login" do
      @email = params[:email]
      @password = params[:password]

      @user = db.exec_params(
        "SELECT * FROM users WHERE email=$1 LIMIT 1",
        [@email]
      ).first

      if @user && BCrypt::Password::new(@user["password"]) == params[:password]
        redirect "/posts"
      else
        redirect "/tryagain"
      end
    end

    post "/signup" do
      @fname = params["fname"]
      @lname = params["lname"]
      @email = params["email"]
      @password = BCrypt::Password::create(params[:password])

      db.exec_params(
        "INSERT INTO users (fname, lname, email, password) VALUES ($1,$2,$3,$4)", [@fname, @lname, @email, @password])

      redirect "/posts"
    end

    get "/posts" do
      @posts = db.exec("SELECT * FROM posts ORDER BY upvotes DESC")
      erb :posts
    end

    post "/posts" do
      @title = params["title"]
      @body = params["body"]
      @language = params["language"]
      @user_name = params["user_name"]
      db.exec_params("INSERT INTO posts (title, body, language, upvotes, user_name) VALUES ($1, $2, $3, $4, $5)",[@title, @body, @language, 0, @user_name])
      redirect to ('/posts')
    end

    get "/posts/:id" do
      @id = params["id"]
      @posts = db.exec_params("SELECT * FROM posts WHERE id = $1", [@id]).first
      @comments = db.exec_params("SELECT * from comments WHERE post_id = $1", [@id])
      erb :post
    end

    post "/comments" do
      @body = params["body"]
      @post_id = params["post_id"]
      @user_name = params["user_name"]

      db.exec_params("INSERT INTO comments (body, upvotes, post_id, user_name) VALUES ($1, $2, $3, $4)",[@body, 0, @post_id, @user_name])
      redirect "/posts/#{@post_id}"
    end

    get "/signup" do
      erb :signup
    end

    get "/login" do
      erb :login
    end

    get "/tryagain" do
      erb :wrong
    end


  end
end
