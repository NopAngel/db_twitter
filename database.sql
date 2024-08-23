
create table users (
  id bigint primary key generated always as identity,
  username text unique not null,
  email text unique not null,
  password_hash text not null,
  created_at timestamp with time zone default now(),
  bio text,
  location text,
  website text,
  profile_image_url text
);

create table tweets (
  id bigint primary key generated always as identity,
  user_id bigint references users (id),
  content text not null,
  created_at timestamp with time zone default now(),
  reply_to_tweet_id bigint references tweets (id),
  retweet_count int default 0,
  like_count int default 0
);

create table followers (
  follower_id bigint references users (id),
  followee_id bigint references users (id),
  followed_at timestamp with time zone default now(),
  primary key (follower_id, followee_id)
);

create table likes (
  user_id bigint references users (id),
  tweet_id bigint references tweets (id),
  liked_at timestamp with time zone default now(),
  primary key (user_id, tweet_id)
);

create table retweets (
  user_id bigint references users (id),
  tweet_id bigint references tweets (id),
  retweeted_at timestamp with time zone default now(),
  primary key (user_id, tweet_id)
);

create table hashtags (
  id bigint primary key generated always as identity,
  tag text unique not null
);

create table tweet_hashtags (
  tweet_id bigint references tweets (id),
  hashtag_id bigint references hashtags (id),
  primary key (tweet_id, hashtag_id)
);

create table direct_messages (
  id bigint primary key generated always as identity,
  sender_id bigint references users (id),
  receiver_id bigint references users (id),
  content text not null,
  sent_at timestamp with time zone default now()
);

create table notifications (
  id bigint primary key generated always as identity,
  user_id bigint references users (id),
  type text not null,
  message text not null,
  created_at timestamp with time zone default now(),
  is_read boolean default false
);

-- Insert sample users

insert into
  users (
    username,
    email,
    password_hash,
    bio,
    location,
    website,
    profile_image_url
  )
values
  (
    'john_doe',
    'john@example.com',
    'hashed_password_1',
    'Love to travel and tweet!',
    'New York, USA',
    'http://johndoe.com',
    'http://example.com/john.jpg'
  ),
  (
    'jane_smith',
    'jane@example.com',
    'hashed_password_2',
    'Tech enthusiast and blogger.',
    'San Francisco, USA',
    'http://janesmith.com',
    'http://example.com/jane.jpg'
  ),
  (
    'alice_wonder',
    'alice@example.com',
    'hashed_password_3',
    'Coffee lover and bookworm.',
    'London, UK',
    'http://alicewonder.com',
    'http://example.com/alice.jpg'
  ),
  (
    'bob_builder',
    'bob@example.com',
    'hashed_password_4',
    'Building the future, one tweet at a time.',
    'Sydney, Australia',
    'http://bobbuilder.com',
    'http://example.com/bob.jpg'
  ),
  (
    'charlie_brown',
    'charlie@example.com',
    'hashed_password_5',
    'Just a regular guy.',
    'Toronto, Canada',
    'http://charliebrown.com',
    'http://example.com/charlie.jpg'
  );

-- Insert sample tweets
insert into
  tweets (
    user_id,
    content,
    reply_to_tweet_id,
    retweet_count,
    like_count
  )
values
  (
    1,
    'Excited to start my journey on Twitter!',
    null,
    5,
    10
  ),
  (
    2,
    'Just published a new blog post on AI trends. Check it out!',
    null,
    3,
    15
  ),
  (
    3,
    'Reading a fascinating book on the history of coffee.',
    null,
    2,
    8
  ),
  (
    4,
    'Working on a new project, can’t wait to share it with you all!',
    null,
    4,
    12
  ),
  (5, 'What a beautiful day!', null, 1, 5);

-- Insert sample followers
insert into
  followers (follower_id, followee_id)
values
  (1, 2),
  (1, 3),
  (2, 1),
  (3, 4),
  (4, 5);

-- Insert sample likes
insert into
  likes (user_id, tweet_id)
values
  (1, 2),
  (2, 1),
  (3, 4),
  (4, 3),
  (5, 5);

-- Insert sample retweets
insert into
  retweets (user_id, tweet_id)
values
  (1, 3),
  (2, 4),
  (3, 1),
  (4, 2),
  (5, 1);

-- Insert sample hashtags
insert into
  hashtags (tag)
values
  ('#AI'),
  ('#Travel'),
  ('#Coffee'),
  ('#Tech'),
  ('#Nature');

-- Insert sample tweet_hashtags
insert into
  tweet_hashtags (tweet_id, hashtag_id)
values
  (1, 2),
  (2, 1),
  (3, 3),
  (4, 4),
  (5, 5);

-- Insert sample direct messages
insert into
  direct_messages (sender_id, receiver_id, content)
values
  (1, 2, 'Hey Jane, loved your latest blog post!'),
  (2, 3, 'Hi Alice, any book recommendations?'),
  (3, 4, 'Bob, your project sounds interesting!'),
  (4, 5, 'Charlie, how’s it going?'),
  (5, 1, 'John, let’s catch up soon!');

-- Insert sample notifications
insert into
  notifications (user_id, type, message)
values
  (1, 'like', 'Jane liked your tweet.'),
  (2, 'follow', 'John started following you.'),
  (3, 'retweet', 'Bob retweeted your tweet.'),
  (4, 'mention', 'Alice mentioned you in a tweet.'),
  (
    5,
    'message',
    'You have a new message from Charlie.'
  );
