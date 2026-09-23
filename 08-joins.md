# 08 Joins

When relating tables, the type of `JOIN` you use determines what happens to data that doesn't have a match in both tables.

## `INNER JOIN` (The Default)

Returns rows ONLY if there is a match in both tables. If a post has no author, the post is completely hidden from the results.

```sql
SELECT posts.title, authors.name
FROM posts
INNER JOIN authors ON posts.author_id = authors.id;
```

## `LEFT JOIN`

Returns ALL rows from the left table (`posts`), even if they don't have a match in the right table. The missing right-side data is simply left as `NULL`.

```sql
SELECT posts.title, authors.name
FROM posts
LEFT JOIN authors ON posts.author_id = authors.id;
```

## `RIGHT JOIN`

The exact opposite of `LEFT JOIN`. It returns ALL rows from the right table (`authors`), even if they haven't written any posts. If an author has no posts, the post columns will be `NULL`.

```sql
SELECT posts.title, authors.name
FROM posts
RIGHT JOIN authors ON posts.author_id = authors.id;
```

## `FULL JOIN` (Full Outer Join)

Combines `LEFT` and `RIGHT` joins. It returns EVERYTHING.

- Posts without authors? Included (with `NULL` for author).
- Authors without posts? Included (with `NULL` for post).
- Matches? Included.

```sql
SELECT posts.title, authors.name
FROM posts
FULL JOIN authors ON posts.author_id = authors.id;
```
