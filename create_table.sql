CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "username" VARCHAR(30) NOT NULL,
  "bio" VARCHAR(400),
  "avatar" VARCHAR(200),
  "phone" VARCHAR(25),
  "email" VARCHAR(40),
  "password" VARCHAR(50),
  "status" VARCHAR(15)

  CHECK(COALESCE(phone, email) is not NULL)
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  url VARCHAR(200) not NULL,
  caption VARCHAR(240),
  lat REAL CHECK(lat is NULL or (lat >= -90 and lat <= 90)),
  lng REAL CHECK(lng is NULL or (lng >= -180 and lng <= 180)),
  user_id INTEGER NOT NULL REFERENCES users(id)
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  contents VARCHAR(240) NOT NULL,
  user_id INTEGER NOT NULL REFERENCES users(id),
  post_id INTEGER NOT NULL REFERENCES posts(id)
)

CREATE TABLE likes (
	id SERIAL PRIMARY KEY,
	created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	user_id INTEGER NOT NULL REFERENCES users(id),
	post_id INTEGER REFERENCES posts(id),
	comment_id INTEGER REFERENCES comments(id),
	CHECK(
		COALESCE(post_id::BOOLEAN::INTEGER, 0)
		+
		COALESCE(comment_id::BOOLEAN::INTEGER, 0)
		= 1
	),
	UNIQUE(user_id, post_id, comment_id)
)

CREATE TABLE photo_tags (
	id serial PRIMARY key,
	created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	post_id INTEGER NOT NULL REFERENCES posts(id),
	user_id INTEGER NOT NULL REFERENCES users(id),
	x INTEGER NOT NULL,
	y INTEGER NOT NULL,
	UNIQUE(user_id, post_id)
)

CREATE TABLE caption_tags (
	id serial PRIMARY key,
	created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	post_id INTEGER NOT NULL REFERENCES posts(id),
	user_id INTEGER NOT NULL REFERENCES users(id),
	UNIQUE(user_id, post_id)
)

create TABLE hashtags(
	id serial PRIMARY key,
	created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	title VARCHAR(20) not NULL UNIQUE
)

create TABLE hashtags_posts(
	id serial PRIMARY key,
	hashtag_id INTEGER NOT NULL REFERENCES hashtags(id),
	post_id INTEGER not NULL REFERENCES posts(id),
	UNIQUE(hashtag_id, post_id)
)

create TABLE hashtags_posts(
	id serial PRIMARY key,
	hashtag_id INTEGER NOT NULL REFERENCES hashtags(id),
	post_id INTEGER not NULL REFERENCES posts(id),
	UNIQUE(hashtag_id, post_id)
)

create table followers (
	id serial PRIMARY KEY,
	created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	leader_id INTEGER NOT NULL REFERENCES users(id),
	follower_id INTEGER NOT NULL REFERENCES users(id),
	UNIQUE(leader_id, follower_id)
)