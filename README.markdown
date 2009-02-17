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

## What is a social network?

* Utility/function 
	* Content is still king (tends to be user-generated, controlled, owned)
	* Content interaction patterns (generating new content, sharing/republishing, modifying/remixing)

* It's People! [Soylent Green reference goes here]
	* user relationships are generally many-to-many 
	* a blog is more of a one-to-many relationship pattern 
	* User interaction patterns (friendships, fans, friends-you-may-know)
	
* Context of web applications
	* Wikipedia has more on the broader, sociological concepts: http://en.wikipedia.org/wiki/Social_network


## Why build a social network?

Let's start with the basics:

* What are you selling ("selling" in the broad sense - again, why will your customers come here)?  
* How are you interacting with your customers?
* How do your customers interact with each other (and those around them)?

Extend: 

* How did people interact with their clientelle outside the standard environment (i.e. outside of the store or the catalog model)  
* progression from newsletters -> email lists -> blogs -> social networks?
* Provide a service (provide some sort of utility) to your customers and potential customers
* 


## How do you build a social network?

* Join as many as you can
	* Get a feel for what others are doing in terms of UI
	* consider this an education in user interaction and user experience
	* Just like reading blogs or books will help you become a better writer, using these applications will inform your development process
	

### Let's start by deciding what our data looks like

At the least, you'll probably have: 
	
* Users
* Relationships (friends/fans)
* Content 

### Pre-Fab vs. from scratch

Scratch:

* it's not too far off from the build-a-blog in 5 minutes example, 
	* you just need a few more models, right?


Prefab:

* insoshi
* ning (sort of)

#### Enter Insoshi

* see also bort, etc
* advantage of having a lot of the interactions laid out for you
* disadvantage: having interactions laid out for you

#### Inshtalling Insoshi

* To sphinx or not to sphinx?
* Yaay, I've got tests, yaaay!

### Building on top of Insoshi

* Users and relationships already exist
* Blogs vs Forums - repurpose for our custom content types

### Some more gems/plugins you might end up using

* acts\_as\_taggable\_on
* ...

### Moving forward

* Join some social networks and start using them
* consider this an education in user interaction and user experience

### Sources, etc

* ...


