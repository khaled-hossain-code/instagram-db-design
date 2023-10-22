-- DROP INDEX users_username_idx
-- CREATE INDEX on users(username)
EXPLAIN ANALYSE
-- 0.8ms with index
-- 12ms without index
SELECT *
from users
WHERE username = 'Emil30'

-- 7lac row 38mb
-- SELECT pg_size_pretty(pg_relation_size('likes'))

