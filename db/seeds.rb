# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Customer.create!(email: "luke@test.com")

user1 = User.create(
    email: "temp100@gmail.com", 
    password: "password", 
    password_confirmation: "password")

profile1 = Profile.create(
    name: "Robert Roy Britt", 
    bio: "Independent health and wellness journalist, founder and editor of Wise & Well, and author of Make Sleep Your Superpower:\n https://www.amazon.com/dp/B0BJBYFQCB", 
    user_id: user1.id)

profile1.avatar.attach(
    io: File.open(Rails.root.join('db', 'seed_images', 'Robert_roy_britt.jpg')), 
    filename: 'Robert_roy_britt.jpg')

topic1 = Topic.create(name: "productivity")


article1 = Article.create(
    title: "When Good Enough is Better Than Perfect", 
    content: "My late father worked as hard as anyone I know throughout his 85 years on this planet. As a small-business owner, self-taught engineer and hands-on builder of his own manufacturing equipment, he put in long hours and worked weekends when needed, while somehow spending a crazy amount of time racing cars, fishing, water skiing, camping, watching sports, fixing things around the house or just goofing off with his family. How did he do so much, so consistently, for so long? How was he so insanely productive and full of fun without ever, to my recollection, burning out? He had a secret weapon. Not an organizing trick. Not a productivity hack. A simple philosophy, a credo, a maxim that he passed on to me, one I feel obliged to share with the world.When approaching the ho-hum conclusion of some challenging project at work or in the garage or around the house, and the result would serve its purpose well enough — even if it leaned on a little duct tape or otherwise lacked professional polish — Dad would say, simply:“Good enough for who it’s for!” Since Dad was self-employed, the “who” was usually him or us, not some demanding overlord. But ultimately isn’t it we, ourselves, who we should seek to please in the end? And anyway, via extensive anecdotal testing at various jobs in my own life, I’ve found that his maxim works pretty well — good enough — no matter who’s in charge. Because progress and success and satisfaction often require simply getting things done, not striving for some hypothetical, subjective ideal, and especially not a notion of perfect we think might be in someone else’s head Function over form. Practicality over style. Done versus neverending. As seen in science Dad never let perfection be the enemy of a profitable step forward in business, a sufficient fix to the house or yard, or the proverbial good time to be had by all. Certain things just needed to get done (the hard, boring or less important stuff) so that he could move on to the things he wanted to do (the more enjoyable, rewarding or… ", 
    user_id: user1.id, 
    topic_id: topic1.id) 

article1.image.attach(
    io: File.open(Rails.root.join('db', 'seed_images', 'article1_featured_image.png')),
    filename: 'article1_featured_image.png')

article1.save

topic2 = Topic.create(name: "Wise & Well")

article2 = Article.create(
    title: "Special Report: Extreme Heat and Human Health", 
    content: "My late father worked as hard as anyone I know throughout his 85 years on this planet. As a small-business owner, self-taught engineer and hands-on builder of his own manufacturing equipment, he put in long hours and worked weekends when needed, while somehow spending a crazy amount of time racing cars, fishing, water skiing, camping, watching sports, fixing things around the house or just goofing off with his family. How did he do so much, so consistently, for so long? How was he so insanely productive and full of fun without ever, to my recollection, burning out? He had a secret weapon. Not an organizing trick. Not a productivity hack. A simple philosophy, a credo, a maxim that he passed on to me, one I feel obliged to share with the world.When approaching the ho-hum conclusion of some challenging project at work or in the garage or around the house, and the result would serve its purpose well enough — even if it leaned on a little duct tape or otherwise lacked professional polish — Dad would say, simply:“Good enough for who it’s for!” Since Dad was self-employed, the “who” was usually him or us, not some demanding overlord. But ultimately isn’t it we, ourselves, who we should seek to please in the end? And anyway, via extensive anecdotal testing at various jobs in my own life, I’ve found that his maxim works pretty well — good enough — no matter who’s in charge. Because progress and success and satisfaction often require simply getting things done, not striving for some hypothetical, subjective ideal, and especially not a notion of perfect we think might be in someone else’s head Function over form. Practicality over style. Done versus neverending. As seen in science Dad never let perfection be the enemy of a profitable step forward in business, a sufficient fix to the house or yard, or the proverbial good time to be had by all. Certain things just needed to get done (the hard, boring or less important stuff) so that he could move on to the things he wanted to do (the more enjoyable, rewarding or… ", 
    user_id: user1.id, 
    topic_id: topic2.id) 

article2.image.attach(
    io: File.open(Rails.root.join('db', 'seed_images', 'article2_featured_image.png')),
    filename: 'article2_featured_image.png')

article3 = Article.create(
    title: "Life is Hard. Here’s How to Cope.", 
    content: "Kieran Setiya has suffered severe pain off and on since age 27. His condition, chronic pelvic pain, was diagnosed by his fifth urologist only after years of zero help from four others. When it flares up, the pulsing, burning pain makes sleep impossible. There’s no cure. Yet Setiya, now 47, is rather philosophical about his suffering — and that of others — whether due to illness, disability, personal failure, grief over the loss of a loved one, war or disasters. “Life, friends, is hard — and we must say so,” he begins in his recently published book, Life is Hard: How Philosophy Can Help Us Find Our Way. “It’s harder for some than it is for others.” Setiya, a philosophy professor at MIT, is acutely aware of how miserable life often is for so many people. Yet he rejects common platitudes proffered during difficult times. The likes of “Don’t worry; it will all be fine!” are dismissive of a person’s agony, he argues. Instead, we must get real and face our many hardships head-on. “There is no cure for the human condition,” he points out. There are remedies, however, science-backed protective mechanisms and positive paths forward — choices in how we think about life when it stinks that are better than wallowing in its stench unnecessarily. And that brings us to the good news: Even in the worst of times, we can be more resilient than we expect. “The empirical evidence suggests that most people are better at coping with difficulty than they fear,” Setiya told me. “They rebound quite rapidly to their emotional baseline” after stressful or traumatic events. We humans are highly adaptive, tending to be as resilient as we need to be, psychology researchers say. So what exactly is resilience? Why do some people seem more resilient than others? And what can we do to bolster our own resilience? While acknowledging that the cards one is dealt can contribute to serious resilience-resistant mental conditions like chronic stress, anxiety disorder and clinical depression, there are… ", 
    user_id: user1.id, 
    topic_id: topic2.id) 

article3.image.attach(
    io: File.open(Rails.root.join('db', 'seed_images', 'article3_featured_image.jpg')),
    filename: 'article3_featured_image.jpg')


user2 = User.create(
    email: "temp101@gmail.com", 
    password: "password", 
    password_confirmation: "password")

profile2 = Profile.create(
    name: "Cory Doctorow", 
    bio: "Writer, blogger, activist. Blog: https://pluralistic.net; Mailing list: https://pluralistic.net/plura-list; Mastodon: @pluralistic@mamot.fr", 
    user_id: user2.id)

profile2.avatar.attach(
    io: File.open(Rails.root.join('db', 'seed_images', 'Cory_doctorow.jpg')), 
    filename: 'Cory_doctorow.jpg')

topic3 = Topic.create(name: "awareness")

article4 = Article.create(
    title: "Fool Me Twice We Don’t Get Fooled Again", 
    content: "I’m kickstarting the audiobook for “The Internet Con: How To Seize the Means of Computation,” a Big Tech disassembly manual to disenshittify the web and bring back the old, good internet. It’s a DRM-free book, which means Audible won’t carry it, so this crowdfunder is essential. Back now to get the audio, Verso hardcover and ebook: http://seizethemeansofcomputation.org “Are you on Bluesky?” Friends, colleagues and strangers have emailed me to ask whether I’ve set up on the new, federatable social media incubated at Twitter and spun out, which many view as a viable Twitter successor. “Are you on Threads?” I get this one too, from people who want to know if I’m going to sign up for the Instagram-derived insta-success that leveraged Facebook’s network effects to achieve an explosive launch (reports of Threads’s subsequent waning are overblown — that kind of “scalloped growth” is normal for new services). Threads, too, is federatable, with a promise to connect it, eventually, to the Fediverse — the collection of services built atop the ActivityPub standard, of which Mastodon is the most famous. I’m not on either service. I’m honored that people would like me to join their conversational spaces, and I’m grateful to the people who offered me signup codes for Bluesky, but I have no plans to join either, and for a very simple reason. I don’t trust ’em. It’s not (just) that Bluesky’s board includes the guy who sold Twitter to Elon Musk. It’s not (just) that Threads is owned by Facebook, a cancer of a company founded to nonconsenually rate the fuckability of Harvard undergrads (incredibly, that was Facebook’s least terrible moment. It actually got worse after that). It’s that neither of these services are actually federated. Both claim that this is coming. Both claim that they have the technical hooks to federate with other services when the time is ripe. But that time isn’t now. Look, I’m done. I poured years and endless hours into establishing myself on walled garden services administered with varying…", 
    user_id: user2.id, 
    topic_id: topic3.id) 
    
article4.image.attach(
    io: File.open(Rails.root.join('db', 'seed_images', 'article4_featured_image.png')),
    filename: 'article4_featured_image.png')
    

article5 = Article.create(
    title: "This day in history.", 
    content: "I’m kickstarting the audiobook for “The Internet Con: How To Seize the Means of Computation,” a Big Tech disassembly manual to disenshittify the web and bring back the old, good internet. It’s a DRM-free book, which means Audible won’t carry it, so this crowdfunder is essential. Back now to get the audio, Verso hardcover and ebook: http://seizethemeansofcomputation.org “Are you on Bluesky?” Friends, colleagues and strangers have emailed me to ask whether I’ve set up on the new, federatable social media incubated at Twitter and spun out, which many view as a viable Twitter successor. “Are you on Threads?” I get this one too, from people who want to know if I’m going to sign up for the Instagram-derived insta-success that leveraged Facebook’s network effects to achieve an explosive launch (reports of Threads’s subsequent waning are overblown — that kind of “scalloped growth” is normal for new services). Threads, too, is federatable, with a promise to connect it, eventually, to the Fediverse — the collection of services built atop the ActivityPub standard, of which Mastodon is the most famous. I’m not on either service. I’m honored that people would like me to join their conversational spaces, and I’m grateful to the people who offered me signup codes for Bluesky, but I have no plans to join either, and for a very simple reason. I don’t trust ’em. It’s not (just) that Bluesky’s board includes the guy who sold Twitter to Elon Musk. It’s not (just) that Threads is owned by Facebook, a cancer of a company founded to nonconsenually rate the fuckability of Harvard undergrads (incredibly, that was Facebook’s least terrible moment. It actually got worse after that). It’s that neither of these services are actually federated. Both claim that this is coming. Both claim that they have the technical hooks to federate with other services when the time is ripe. But that time isn’t now. Look, I’m done. I poured years and endless hours into establishing myself on walled garden services administered with varying…", 
    user_id: user2.id, 
    topic_id: topic3.id) 
    
article5.image.attach(
    io: File.open(Rails.root.join('db', 'seed_images', 'article4_featured_image.png')),
    filename: 'article4_featured_image.png')
    
Follow.create(follower_id:user2.id, following_id: user1.id)
Follow.create(follower_id:user1.id, following_id: user2.id)

Like.create(article_id: article1.id, user_id: user2.id)
Like.create(article_id: article2.id, user_id: user2.id)
Like.create(article_id: article3.id, user_id: user2.id)

Like.create(article_id: article4.id, user_id: user1.id)
Like.create(article_id: article5.id, user_id: user1.id)

Comment.create(article_id: article1.id, content: "Insightfull", user_id: user2.id)
Comment.create(article_id: article2.id, content: "Insightfull", user_id: user2.id)
Comment.create(article_id: article3.id, content: "Insightfull", user_id: user2.id)

Comment.create(article_id: article4.id, content: "Insightfull", user_id: user1.id)
Comment.create(article_id: article5.id, content: "Insightfull", user_id: user1.id)


View.create(article_id: article1.id, user_id: user2.id)
View.create(article_id: article2.id, user_id: user2.id)
View.create(article_id: article3.id, user_id: user2.id)

View.create(article_id: article4.id, user_id: user1.id)
View.create(article_id: article5.id, user_id: user1.id)


Saveforlater.create(user_id: user1.id, article_id: article4.id)
Saveforlater.create(user_id: user2.id, article_id: article1.id)

list1 = List.create(name: "Wellbeing", user_id: user1.id)
list2 = List.create(name: "Gym", user_id: user1.id)
list3 = List.create(name: "Dance", user_id: user1.id)
list4 = List.create(name: "Art", user_id: user2.id)


Userlist.create(list_id: list1.id, article_id: article5.id)
Userlist.create(list_id: list1.id, article_id: article4.id)

Userlist.create(list_id: list2.id, article_id: article4.id)
Userlist.create(list_id: list2.id, article_id: article5.id)
Userlist.create(list_id: list3.id, article_id: article1.id)


draft = Draft.create(
    title: "This day in history.", 
    content: "I’m kickstarting the audiobook for “The Internet Con: How To Seize the Means of Computation,” a Big Tech disassembly manual to disenshittify the web and bring back the old, good internet. It’s a DRM-free book, which means Audible won’t carry it, so this crowdfunder is essential. Back now to get the audio, Verso hardcover and ebook: http://seizethemeansofcomputation.org “Are you on Bluesky?” Friends, colleagues and strangers have emailed me to ask whether I’ve set up on the new, federatable social media incubated at Twitter and spun out, which many view as a viable Twitter successor. “Are you on Threads?” I get this one too, from people who want to know if I’m going to sign up for the Instagram-derived insta-success that leveraged Facebook’s network effects to achieve an explosive launch (reports of Threads’s subsequent waning are overblown — that kind of “scalloped growth” is normal for new services). Threads, too, is federatable, with a promise to connect it, eventually, to the Fediverse — the collection of services built atop the ActivityPub standard, of which Mastodon is the most famous. I’m not on either service. I’m honored that people would like me to join their conversational spaces, and I’m grateful to the people who offered me signup codes for Bluesky, but I have no plans to join either, and for a very simple reason. I don’t trust ’em. It’s not (just) that Bluesky’s board includes the guy who sold Twitter to Elon Musk. It’s not (just) that Threads is owned by Facebook, a cancer of a company founded to nonconsenually rate the fuckability of Harvard undergrads (incredibly, that was Facebook’s least terrible moment. It actually got worse after that). It’s that neither of these services are actually federated. Both claim that this is coming. Both claim that they have the technical hooks to federate with other services when the time is ripe. But that time isn’t now. Look, I’m done. I poured years and endless hours into establishing myself on walled garden services administered with varying…", 
    user_id: user2.id) 
