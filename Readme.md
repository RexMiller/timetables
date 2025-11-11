# Hello!
Thank you for the opportunity to work on this assessment. It was fun!

Answers to the questions in the instructions are below. For details about the application design [go here](Readme.design.md) 💻.

### How long did it take?
I'd say it took about 20 hours. I got pretty drawn into some of the interesting problems it presented.


### How would you scale to production for a heavy load?
Devops and infrastructure aren't my strengths, but I would say the first concern would be moving the service to a platform that supports scaling instances or compute resources, or both. That could be a Kubernetes node that distributes load across multiple pods, or something like an Azure (or other flavor) app service that supports scaling up compute resources ☁️ 

For the database, assuming we're sticking with the relational approach, I'd have to vote for MS SQL server, preferably a cloud flavor that we can scale as needed. The choice of the MS flavor is entirely because that's what I have experience with though, and I imagine PostgreSQL could rock it too 🤷‍♂️

I would also be tempted to explore a document database. I could see a world where the application is closely oriented around objects at some aggregate root level, like a given route, and then hydrating a route with its child entities becomes very clean and natural. I could also see that world becoming very messy with the potential complexity of stops and timetables differing for weekdays and weekends, and having exceptions for holidays or transient conditions. If there are voluminous contingencies they would be hard to capture in an object graph. But it's an interesting hammer to consider 🤔

### Let's talk about AI…
I made the intentional choice to use AI the way I use it in my current role: that is to say responsibly—to increase efficiency, never to substitute for understanding. I don't use AI to do the thinking for me. Vibe coding is creepy 🤖

I used Claude Sonnet (via Copilot):
- As a rapid reference, more efficient than browsing API documentation.
- To automate repetitive tasks or data generation. Specifically, I used it to generate times for the stops in the database initialization script.
- To generate the ERD for the database from the initialization script.

I used ChatGPT to accelerate learning Alpine.js—not as a substitute for learning it or to do the work for me.

I'm happy to talk more about how I apply AI to my work if you have any questions or concerns.