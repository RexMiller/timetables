# Hello!

Thank you for the opportunity to work on this assessment. It was fun!

First, my answers to the questions in the instructions.

### How long did it take?

<p>
I'd say it took about 20 hours. I didn't want to rush it, and it I got pretty drawn into some of the interesting problems it presented.
</p>

### How would you scale to a heavy load production environment?
 
 <p>
 Devops and infrastructure aren't my strengths, but I would say the first concern would be moving the service to a platform that supports scaling instances or compute resources, or both. That could be a Kubernetes node that distributes load across multiple pods, or something like an Azure app service that supports scaling up compute resources.
 </p>

 <p>
 For the database, assuming we're sticking with the relational approach, I'd have to vote for MS SQL server, preferably a cloud flavor that we can scale as needed. I imagine PostgreSQL would be a solid choice too but I don't have any experience with it 🤷‍♂️
 </p>

 <p>
 Depending on other use cases and certain characteristics of the data at scale, I'd be tempted to see if we could get away with a document database though. I could see a world where the application is working primarily with objects at some aggregate root level, like a given route, and then hydrating a route with its child entities becomes very clean and natural. That said, I could also see that world becoming very messy with the potential complexity of stops and timetables, likely differing for weekdays and weekends, and having exceptions for holidays or transient conditions. If there are voluminous contingencies they would be hard to capture in an object graph. But I find it interesting to consider. 🤔
 </p>


![Timetables ERD](data/Timetables.erd.png "Timetables ERD")