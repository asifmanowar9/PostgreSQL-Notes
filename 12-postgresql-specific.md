# 12 Postgresql Specific

While standard SQL is powerful, PostgreSQL includes several native data types that give it the flexibility of NoSQL databases, without sacrificing the safety of a relational database.

## Arrays

You can store a list of items directly in a single column by adding `[]` to the data type.

```sql
-- Creating an array column
ALTER TABLE posts ADD COLUMN tags TEXT[];

-- Inserting an array
UPDATE posts SET tags = ARRAY['sql', 'learning', 'postgres'] WHERE id = 1;
```

### Querying Arrays

To search for a specific item inside an array, you use the `ANY()` operator.

```sql
-- Find all posts that have 'sql' in their tags array
SELECT title FROM posts WHERE 'sql' = ANY(tags);
```

## JSON and JSONB

PostgreSQL can store JSON data. You should almost always use `JSONB` (Binary JSON) instead of `JSON`, because `JSONB` is parsed and stored in a binary format, making it significantly faster to query and allowing for indexing.

```sql
-- Creating a JSONB column
ALTER TABLE posts ADD COLUMN metadata JSONB;

-- Inserting JSON data
UPDATE posts
SET metadata = '{"views": 100, "is_featured": true, "theme": "dark"}'
WHERE id = 1;
```

### Querying JSONB

You can extract specific values from the JSON object using the `->>` operator (which returns the value as text) or the `->` operator (which returns the value as a JSON object).

```sql
-- Find all posts where the theme inside the metadata is 'dark'
SELECT title, metadata->>'views' as view_count
FROM posts
WHERE metadata->>'theme' = 'dark';
```

## ENUMs (Enumerated Types)

An ENUM is a custom data type where you explicitly define a static, ordered set of allowed values. It is safer than using a plain `TEXT` column because the database will reject any value that isn't in your list.

```sql
-- Create the custom ENUM type
CREATE TYPE post_status AS ENUM ('draft', 'published', 'archived');

-- Add a column using your new custom type
ALTER TABLE posts ADD COLUMN status post_status DEFAULT 'draft';
```
