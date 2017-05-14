## 11-03
Users following other users. What does that mean? We want to follow other users and maybe show them on our profile page? We could display a (new) if they have posted a new review that we haven't seen yet. How can we do that? We need to track the last time that page has been visited and compare it to the creation of new reviews for that user. That is something I can add later. For now I need to think

User associates with user in a relationship. Leading and following relation ship. This is a many to many. A leader can have many follows and many leaders. A user can follow many users. That is it. A user can reference another user. Self-referencing? No, I would need a join table. A user has a relationship.

relationship, follower_id, leader_id and that is it. I could also have a last visited column for the last time the follower has visited the user and then they could be notified when the follower follows the leader.

Okay. So, a followable relationship for a business and users

user follows user
user follows business

ie. user follows followable
followable has many users through relationships

id, user_id, followable_type, followable_id
1   1        User             3
2   1        Business         1
