[DRAFT]

----------

Learning Objectives:

* Non-Developer types will know what a social network is 
* Non-Developer types be able to think critically about how or why they might use an SN
* Developer types will know how to explain what a social network is
* Developer types will be able to explain to Non-Developer types why they should (or shouldn't use an SN) 
* Developer types will be able to build a basic social network app using existing tools
* ...

----------

# Simple Social Networking With Ruby on Rails

Abstract: What is a social network? Why build a social network? How might one build a social network?  As we explore these questions, we will look at the development of a social networking application that is built on top of the Ruby on Rails platform Insoshi.

About the presenter(s?): By day, Justin Henry [http://jdhenry.com] is a mild mannered application administrator at a Public Ivy somewhere in New England.  By night, Mr. Henry puts on his cape and develops custom web applications for fun and profit.

A few networks I'm on:

* [screenshot of gg about page]
* [screenshot of FF accounts page]

## What is a social network?

* Context of web applications
	* Wikipedia has more on the broader, sociological concepts
	* http://en.wikipedia.org/wiki/Social_network

* Provides a Utility and/or Function for users
	* Content is still king 
	* Content tends to be user-generated, controlled, and owned (unless you are FB, apparently)
	* Content interaction patterns (generating new content, sharing/republishing, modifying/remixing)

* It's People! 
	* user relationships are generally many-to-many 
	* a blog is more of a one-to-many relationship pattern 
	* User interaction patterns (friendships, fans, friends-you-may-know)
	
## Why build a social network?

* What are you selling?
	* An idea, product, theology, movement, etc.
* Why will your users come here?  

* What channels do you currently reach with your customers?
	* How are you interacting with your customers?
	* How do your customers interact with each other?
	* How do your customers interact with their customers and others around them?

* The evolution of the newsletter
	* newsletters -> email lists -> blogs -> social networks?

* It's fun!
* Provide a service to customers and potential customers
* Crowdsourcing - i.e. google's image word game
* Think small - it doesn't have to be the next Facebook.
* Karma - putting the Service and the Community back in community service
* Scratch that itch (whiteboard in the sky)


## How do you build a social network?

* Join as many as you can
	* Get a feel for what others are doing in terms of UI
	* consider this an education in user interaction and user experience
	* Just like reading blogs or books will help you become a better writer.
	* Using these applications will inform your development process	 

### Let's start by thinking about what our data looks like

At the least, you'll probably have: 
	
* Users
* Relationships (friends/fans)
* Content 

### Pre-Fab vs. Home Cookin'

Building from Scratch

* It's not too far off from the build-a-blog in 5 minutes example 
* Just need a few more models, right?
* Add in a few plugins....

Example relationships

Insoshi's connections migrations:

create_table "connections", :force => true do |t|
  t.integer  "person_id"
  t.integer  "contact_id"
  t.integer  "status"
  t.datetime "accepted_at"
  t.datetime "created_at"
  t.datetime "updated_at"
end

Dan Fischer's "FischyFriends" example migration

create_table :friendships do |t|
	t.integer  "user_id",    :null => false
	t.integer  "friend_id",  :null => false
	t.datetime "created_at" 
	t.datetime "updated_at" 
	t.timestamps
end

A few plugins and tools for consideration:

* Paperclip
* acts\_as\_commentable
* acts\_as\_taggable\_on

Prefab:

* Refactoring other people's code is a great way to learn

Several options exist in the rails community:

* Community Engine - bills itself as a "plugin"
* Insoshi platform
* Ning (furniture included!)
* Bort, etc (just the walls, please)
* ... and many more ...

#### Enter Insoshi

* Advantage: having a lot of pieces laid out for you
	* galleries, forums, blogs, messaging, activity feeds, events
* Disadvantage: having a lot of pieces laid out for you
	* may be lots to change or retrofit to your needs

#### Inshtalling Insoshi

* To sphinx or not to sphinx?
	* might depend on db you are using (don't need it for postgres)
	* installing sphinx on OSX is a pain - need to add symlink, i.e.:
	* sudo ln -s /usr/local/mysql/lib /usr/local/mysql/lib/mysql
	* after, it runs pretty smoothly
* To install without sphinx, just skip that part of the install process.
* Yaay, I've got tests, yaaay!
* installer script installs gems

### Building on top of Insoshi

* Users and relationships already exist
* Choose a model(s) to repurpose as needed (i.e. for custom content)
* Build new model(s) for custom content and interactions

### Example App - MyEventCarbon

* Idea:  Set up an app to let attendees and promoters of local events:
 	* track the carbon footprint of their events 
	* organize carpools
	* suggest bus routes and other alternatives

* Repurpose Insoshi's nascent event model
* Use Gmaps api for geocoding
* AMEE for carbon calculations (ammee.com)
* Plugins
	* ym4r for embedding google maps
	* rspec\_response\_enhancer - add more descriptive output to rspec
	* Floppy-amee - for interacting with AMEE data

* Demo:
	* create account, 
	* register for event

* Next steps 
	* Carpooling offering/accepting/tracking
	* Live carbon calculations
	* Pull events from other services
	* Import ical files, RSS, microformats (hcal)
	* Adding to activity feed

* Tests appear to be generated?
* Odd mass-assignment solution
* calendar date select widget is broken 



### Moving forward

* Join some social networks and start using them!
* 

### Sources, Resources, and paths for further exploration

* Wikipedia article on "Social Network" http://en.wikipedia.org/wiki/Social_network
* Jim Neath > Building a Social Network Site in Rails: http://jimneath.org/2008/04/25/building-a-social-network-site-in-rails/
* MissingMethod > How To Build a Social Network with Ruby on Rails:  http://www.missingmethod.com/2007/01/08/how-to-build-a-social-network-with-ruby-on-rails/

* Friendship model examples & self referential models: 
	* Dan Fischer > Fischyfriends: http://github.com/dfischer/fischyfriends/tree/master
	* Josh Susser > Self-referential has_many :through associations: http://blog.hasmanythrough.com/2007/10/30/self-referential-has-many-through


