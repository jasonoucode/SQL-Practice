-- We want to reward our users who have been around the longest.
-- (1) Find the 5 oldest users.

SELECT *
FROM users
ORDER BY users.created_at
LIMIT 5;


-- We need to figure out when to schedule an ad campgain.
-- (2) What day of the week do most users register on?

SELECT
	users.username,
	DAYNAME(users.created_at) AS day_of_week,
	count(*) AS 'total_users'
FROM users
GROUP BY day_of_week
ORDER BY total_users DESC
LIMIT 1;


-- We want to target our inactive users with an email campgain.
-- (3) Find the users who have never posted a photo

SELECT
	users.username AS 'inactive_users'
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.id IS NULL;


-- We're running a new contest to see who can get the most likes on a single photo.
-- (4) Who won? Find the user with the most likes on their photo.

SELECT
	users.username,
	photos.id,
	photos.image_url,
	COUNT(*) AS 'total_likes'
FROM photos
INNER JOIN likes
	ON photos.id = likes.photo_id
INNER JOIN users
	ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;


-- Our investors want to know
-- (5) How many times does the average user post?

SELECT
	(SELECT COUNT(*) FROM photos)
	/
	(SELECT COUNT(*) FROM users) AS 'user_avg_posts';


-- A brand wants to know which hashtags to use in a post
-- (6) What are the top 5 most commonly used hashtags?

SELECT
	tags.tag_name,
	COUNT(*) AS 'tag_count'
FROM photo_tags
INNER JOIN tags
	ON photo_tags.tag_id = tags.id
GROUP BY tags.tag_name
ORDER BY tag_count DESC
LIMIT 5;


-- We have a small problem with bots on our site...
-- (7) Find users who have liked every single photo on the site.

SELECT
	users.username,
	COUNT(*) AS 'total_likes'
FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes = (SELECT COUNT(*) FROM photos);

