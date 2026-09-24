# PostgreSQL Cheatsheet (My Project)

A quick reference guide featuring the exact queries and commands executed during the creation of the `learning_db` database.

## 1. Environment & `psql` Commands

**Start the Docker Database**

```bash
docker compose up -d
```

**Connect to the Database**

```bash
docker exec -it pg_learning psql -U myuser -d learning_db
```

**Helpful `psql` Meta-commands**

- `\c db_name` - Switch databases
- `\dt` - List tables in the `public` schema
- `\dt store.*` - List tables in a specific schema
- `\d posts` - Describe the structure of the `posts` table
- `\q` - Quit

---

## 2. DDL & Constraints (Defining Data)

**Schemas and Tables**

```sql
CREATE SCHEMA store;

CREATE TABLE store.products (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT
);
```

**Adding Constraints (`UNIQUE`, `CHECK`)**

```sql
ALTER TABLE store.products ADD CONSTRAINT unique_product_name UNIQUE (name);
ALTER TABLE store.products ADD COLUMN price DECIMAL CHECK (price > 0);
```

**Custom Types (ENUM)**

```sql
CREATE TYPE post_status AS ENUM ('draft', 'published', 'archived');
ALTER TABLE posts ADD COLUMN status post_status DEFAULT 'draft';
```

---

## 3. DML (Modifying Data)

**Insert with `RETURNING`**

```sql
INSERT INTO authors (name) VALUES ('Bob') RETURNING id;
```

**UPSERT (`ON CONFLICT`)**
_(Note: Requires `OVERRIDING SYSTEM VALUE` because our ID is `GENERATED ALWAYS`)_

```sql
INSERT INTO posts (id, title, content)
OVERRIDING SYSTEM VALUE
VALUES (4, 'My first post', 'This is the content of my post.')
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    content = EXCLUDED.content
RETURNING id, published_at;
```

---

## 4. Querying & Aggregation

**`LEFT JOIN` (Including Missing Data)**

```sql
SELECT posts.title, authors.name
FROM posts
LEFT JOIN authors ON posts.author_id = authors.id;
```

**Aggregation with `HAVING`**

```sql
SELECT author_id, COUNT(*)
FROM posts
GROUP BY author_id
HAVING COUNT(*) > 1;
```

**Subqueries (`IN`)**

```sql
SELECT title
FROM posts
WHERE author_id IN (
    SELECT id FROM authors WHERE name = 'Bob'
);
```

---

## 5. Advanced SQL

**Chaining CTEs (`WITH`)**

```sql
WITH RecentPosts AS (
    SELECT * FROM posts WHERE published_at > '2020-01-01'
),
BobPosts AS (
    SELECT * FROM RecentPosts WHERE author_id = 2
)
SELECT title FROM BobPosts;
```

**Window Functions (Cumulative Sum with Tie-Breaker)**

```sql
SELECT title, 10 as views_for_this_post,
SUM(10) OVER (
    PARTITION BY author_id
    ORDER BY published_at ASC, id ASC
) as running_total_views
FROM posts WHERE author_id = 1;
```

---

## 6. PostgreSQL Specific Types

**Querying Arrays (`ANY`)**

```sql
SELECT title FROM posts WHERE 'sql' = ANY(tags);
```

**Querying JSONB (`->>`)**

```sql
SELECT title FROM posts WHERE metadata->>'theme' = 'dark';
```

---

## 7. Performance & Transactions

**`EXPLAIN ANALYZE` and Indexes**

```sql
-- View the Query Planner X-Ray
EXPLAIN ANALYZE SELECT * FROM posts WHERE title = 'A post by Bob';

-- Create specialized indexes
CREATE INDEX idx_published_titles ON posts(title) WHERE status = 'published';
CREATE INDEX idex_author_and_date ON posts(author_id, published_at);
CREATE INDEX idx_posts_metadata ON posts USING GIN (metadata);
```

**Partial Rollbacks (`SAVEPOINT`)**

```sql
BEGIN;
INSERT INTO authors (name) VALUES ('Good Author');
SAVEPOINT safe_place;
INSERT INTO authors (name) VALUES ('Oops, a mistake');
ROLLBACK TO SAVEPOINT safe_place;
COMMIT;
```

---

## 8. Security & Backups

**Row Level Security (RLS)**

```sql
CREATE ROLE app_user WITH LOGIN PASSWORD 'securepasword123';
GRANT CONNECT ON DATABASE learning_db TO app_user;
GRANT SELECT, INSERT ON TABLE posts TO app_user;

ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
CREATE POLICY restrict_post_access ON posts
    FOR SELECT TO app_user
    USING (current_user = 'Asif');
```

**Backup & Restore (via Terminal)**

```bash
# Export the database to a file
docker exec -t pg_learning pg_dump -U myuser -d learning_db -c > my_database_backup.sql

# Restore the database from the file
docker exec -i pg_learning psql -U asif -d learning_db < my_database_backup.sql
```
