create view recent_posts AS (
SELECT *
FROM posts
ORDER by created_at DESC
LIMIT 10
)
