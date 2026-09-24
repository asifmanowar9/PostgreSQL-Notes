# 07 Select And Filtering

While simple equality checks (`WHERE id = 1`) are common, you frequently need to search for text patterns, check if a value falls within a list or range, and limit the number of results for pagination.

## Text Pattern Matching (`LIKE` and `ILIKE`)

You can search for partial text matches using wildcards. The `%` symbol represents any number of characters (including zero).

- `LIKE`: Case-sensitive search.
- `ILIKE`: **Case-insensitive** search (PostgreSQL specific, highly recommended for user searches).

```sql
-- Finds any title that contains the word 'post', regardless of capitalization.
SELECT title FROM posts WHERE title ILIKE '%post%';

-- Finds titles that START with 'The'
SELECT title FROM posts WHERE title ILIKE 'The%';
```

## Lists and Ranges

### The `IN` Operator

Instead of writing long `OR` statements (`id = 1 OR id = 2 OR id = 5`), you can use `IN` to check against a list.

```sql
SELECT title FROM posts WHERE author_id IN (1, 2, 5);
```

### The `BETWEEN` Operator

Useful for filtering numbers or dates within an inclusive range.

```sql
SELECT title FROM posts WHERE published_at BETWEEN '2026-01-01' AND '2026-12-31';
```

## Pagination (`LIMIT` and `OFFSET`)

When building applications, you rarely want to fetch 10,000 rows at once. You fetch them in chunks (pages).

- `LIMIT`: The maximum number of rows to return.
- `OFFSET`: The number of rows to skip before starting to return data.

```sql
-- "Page 2" of a blog, assuming 10 posts per page.
SELECT title FROM posts
ORDER BY published_at DESC
LIMIT 10 OFFSET 10;
```

_(Always use `ORDER BY` when using `LIMIT`/`OFFSET`, otherwise the database might return the rows in a random, unpredictable order!)_
