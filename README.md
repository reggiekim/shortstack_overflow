#ShortstackOverflow
###by Reggie Kim

http://shortstack-overflow.herokuapp.com/

##Description
ShortstackOverflow is a beginner's alternative to Stack Overflow, where programmers can ask very basic questions and get easy to understand answers.  No assholes allowed, humor is recommended.

With ShortstackOverflow (SO), you can read other people's questions and answers.  You can also see how many upvotes or comments each post has.  If you want to ask questions, you have to sign up with SO.  Once you register, you can also vote on questions you think that might be helpful to others.

##Techlogies used
* Sinatra - used for routing
* BCrypt - used for storing and encrypted passwords

##How to download and run on your server
1. Download the Shortstack_Overflow directory to your computer
1. Open your Terminal and cd into the Shortstack_Overflow directory
1. Run "Ruby lib/seeds.rb" to set up the database on your local server
1. From the same Shortstack_Overflow directory, run "rackup"
1. If successful, you will see four numbers on the last line after port. For example "....port=9292"
1. Open your browser and enter "http://localhost:XXXX/", or as in our example "http://localhost:9292/"

##Resources
ERD:
[Imgur](http://i.imgur.com/skLeqf2.jpg)

Wireframe:
[Imgur](http://i.imgur.com/0IFGZ4w.jpg)
