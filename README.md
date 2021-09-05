# Ballerina TopChart twitter
In our application is a music application which will send tweets about the news in the music industry and Latest music charts of last.fm

ps: The following text and this code was originally written in 2017 during the Ballerina Hackathon. Fixed several Grammer Errors;



## Team Elementry
The team was consisted of Isuru Sachitha, Kasun Kavishka, Dilshan Naveen and Navin Thamindu



## How we made it
We thought to build an music chart app which could be updated by a database in the cloud in the first place, but as we started ballerina with a hello world today morning, we were unable to achieve our goal.
Therefore we buid an app which scraps the latest news from the RSS feed of MTV and posts it on twittter using the twitter API. Also we used the Last.fm's API. From it, information about the lastest songs are taken as JSON file. Then our program extracts the useful data, Process them and posts them on twitter.



## What we found as Bugs
When we send more than one tweets in one run, its shaws an error message saying "already existed". Sometimes, the code compiles and runs well but the tweets does not show up on twitter. 



## Why we love ballerina
-It seems that ballerina is a very good language. 
-It felt like an all-in-one and a complete lang. 
-It can do magic when it comes to connecting two endpoints together. 
-In our point of view ballerina is awesome for backend



## Why we hate ballerina-
-There were no much learning resourses about Ballerina so we got confused when starting the learning it for the first time.
-Much appreciated if ballerina is also great in front-end/ui programming.
	
	
