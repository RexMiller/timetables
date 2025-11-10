# Hello!
Thank you for the opportunity to work on this assessment. It was fun!

Here are my answers to the questions in the instructions.

### How long did it take?
I'd say it took about 20 hours. I got pretty drawn into some of the interesting problems it presented.


### How would you scale to a heavily loaded production environment?
Devops and infrastructure aren't my strengths, but I would say the first concern would be moving the service to a platform that supports scaling instances or compute resources, or both. That could be a Kubernetes node that distributes load across multiple pods, or something like an Azure app service that supports scaling up compute resources.

For the database, assuming we're sticking with the relational approach, I'd have to vote for MS SQL server, preferably a cloud flavor that we can scale as needed. The choice of the MS flavor is entirely because that's what I have experience with though, and I imagine PostgreSQL could rock it too 🤷‍♂️

I would also be tempted to explore a document database. I could see a world where the application is working primarily with objects at some aggregate root level, like a given route, and then hydrating a route with its child entities becomes very clean and natural. I could also see that world becoming very messy with the potential complexity of stops and timetables, differing for weekdays and weekends, and having exceptions for holidays or transient conditions. If there are voluminous contingencies they would be hard to capture in an object graph. But I do love me some document dbs so they are an attractive hammer. 🤔

### Let's talk about AI…
I made the intentional choice to use AI the way I use it in my current role: that is to say responsibly—to increase efficiency, never to substitute for understanding. I never use AI to do the work—and especially not the thinkig—for me. Vibe coding is creepy 🤖

Specifically, I used AI:
- As a rapid reference. It's more efficient than browsing API documentation.
- As a research assistant—essentially a shortcut for combing though mountains of search results for the actual information you're seeking.
- Automating repetitive tasks or data generation. Specifically, I used it to generate times for the stops in the database initialization script.

I'm happy to talk more about how I apply AI to my work if you have any questions or concerns.

For a guide to the application design, [go here](Readme.design.md) .