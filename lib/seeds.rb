require 'pg'

if ENV["RACK_ENV"] == "production"
    db = PG.connect(
        dbname: ENV["POSTGRES_DB"],
        host: ENV["POSTGRES_HOST"],
        password: ENV["POSTGRES_PASS"],
        user: ENV["POSTGRES_USER"]
     )
else
    db = PG.connect(dbname: "ss_overflow_db")
end

db.exec("DROP TABLE IF EXISTS users")
db.exec("DROP TABLE IF EXISTS posts CASCADE")
db.exec("DROP TABLE IF EXISTS comments")

db.exec("CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    fname VARCHAR,
    lname VARCHAR,
    email VARCHAR,
    password VARCHAR
  )"
)

db.exec("CREATE TABLE posts(
    id SERIAL PRIMARY KEY,
    title VARCHAR,
    body TEXT,
    language VARCHAR,
    upvotes INTEGER,
    comment_count INTEGER,
    user_name VARCHAR
  )"
)

db.exec("CREATE TABLE comments(
    id SERIAL PRIMARY KEY,
    body TEXT,
    upvotes INTEGER,
    post_id INTEGER REFERENCES posts(id),
    user_name VARCHAR
  )"
)


# Couldn't get sessions to work for me so I changed my tables (post, comments) key values from user_id to user_name.  user_id was referencing the user table, but since sessions doesn't work, went away from that in the end.

#db.exec("INSERT INTO users (fname, lname, email, password) VALUES ('Reggie','Kim','reggiekim@gmail.com','p4ssword')")
#db.exec("INSERT INTO posts (title, body, language, upvotes, user_id) VALUES ('What is console.log?','I saw this line of code in my friends project and I have no idea what it does. What does console.log mean?','JavaScipt',0,1)")
#db.exec("INSERT INTO comments (body, upvotes, post_id, user_id) VALUES ('A javascript debugging tool that lets you print to the console',0,1,1)")
#db.exec("INSERT INTO comments (body, upvotes, post_id, user_id) VALUES ('and it doesnt render on the browser view',0,1,1)")
