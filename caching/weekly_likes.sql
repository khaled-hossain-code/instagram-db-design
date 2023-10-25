CREATE MATERIALIZED VIEW weekly_likes AS (
SELECT
	date_trunc('week', COALESCE(posts.created_at, "comments".created_at)) as week, COUNT("comments".id) as num_likes_for_comments, COUNT(posts.id) as num_likes_for_posts
FROM likes
LEFT JOIN comments ON likes.comment_id = comments.id
LEFT JOIN posts ON likes.post_id = posts.id
GROUP by week
ORDER by week
) WITH DATA;

-- select * from weekly_likes

-- REFRESH MATERIALIZED VIEW weekly_likes;
