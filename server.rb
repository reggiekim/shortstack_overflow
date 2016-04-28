module Sinatra
  class Server < Sinatra::Base
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
      erb :index
    end

    get "/posts" do
      @posts = db.exec("SELECT * FROM posts ORDER BY upvotes DESC")
      erb :posts
    end

    get "/posts/:id" do
      @id = params[:id]
      @posts = db.exec("SELECT * FROM posts WHERE id = #{@id}").first
      @comments = db.exec("SELECT * from comments WHERE post_id = #{@id}")
      erb :post
    end

    get "/login" do
      erb :login
    end

    get "/signup" do
      erb :signup
    end

  end
end
