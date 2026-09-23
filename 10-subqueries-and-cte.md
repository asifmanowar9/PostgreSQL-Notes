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
