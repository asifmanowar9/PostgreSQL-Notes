# 10 Subqueries And Cte

## Subqueries

A subquery is a query nested inside another query. They are very common inside `WHERE` clauses to filter data based on the results of another table, without needing to write a full `JOIN`.

```sql
SELECT title
FROM posts
WHERE author_id IN (
    -- Inner query finds the author ID
    SELECT id FROM authors WHERE name = 'Asif'
);
```

## Common Table Expressions (CTEs)

A CTE (using the `WITH` keyword) is essentially a subquery that you define at the top of your script. It allows you to break complex queries into readable, temporary tables that exist only for the duration of the query.

```sql
WITH AuthoredPosts AS (
    -- CTE: Isolate only the posts that have an author.
    SELECT id, title, author_id
    FROM posts
    WHERE author_id IS NOT NULL
)
-- Main Query: We treat 'AuthoredPosts' as if it were a real table.
SELECT authors.name, AuthoredPosts.title
FROM AuthoredPosts
JOIN authors ON AuthoredPosts.author_id = authors.id;
```

### Advanced CTEs: Chaining
You can chain multiple CTEs together to create a readable data pipeline. Each CTE can query the results of the CTE directly above it.

```sql
WITH AsifsPosts AS (
    -- CTE 1: Get only Asif's posts
    SELECT id, title FROM posts WHERE author_id = 1
),
FilteredPosts AS (
    -- CTE 2: Read from CTE 1, not the main table!
    SELECT id, title FROM AsifsPosts WHERE title ILIKE '%post%'
)
-- Main Query: Output the result of the final CTE
SELECT COUNT(*) as final_count FROM FilteredPosts;
```

### Advanced CTEs: Data Modification
PostgreSQL allows you to run `INSERT`, `UPDATE`, or `DELETE` inside a CTE, and pass the modified rows to the next step using `RETURNING`.

```sql
WITH DeletedPost AS (
    -- Delete the row, but grab its title on the way out
    DELETE FROM posts WHERE id = 5 RETURNING title
)
-- Insert a log of what we just deleted into an audit table
INSERT INTO audit_logs (action, resource_name)
SELECT 'Deleted a post', title FROM DeletedPost;
```
