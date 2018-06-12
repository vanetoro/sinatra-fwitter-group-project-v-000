vane = User.create(username: 'Vane', email: 'vane@me.com', password: 'pass12')
rachel = User.create(username: 'Rachel', email: 'Rachel@me.com', password: 'pass12')

tweet1 = Tweet.create(content: "This is my first tweet")
tweet2 = Tweet.create(content: 'This tweeting stuff is kinda cool.')

vane.tweets << tweet1
vane.tweets << tweet2
