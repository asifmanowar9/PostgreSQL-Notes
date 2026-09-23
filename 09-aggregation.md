# 09 Aggregation

Often, you don't want raw rows; you want calculations (like sums or counts) based on categories.

## Simple Aggregation (`COUNT`)

To count the total number of rows in a table:

```sql
SELECT COUNT(*) FROM posts;
```

## Grouping Data (`GROUP BY`)

To get a count _per category_, you tell the database which column to create the groups from.

```sql
-- How many posts does EACH author have?
SELECT author_id, COUNT(*)
FROM posts
GROUP BY author_id;
```

_Note: If there are rows where `author_id` is NULL, PostgreSQL will group them into their own "blank" bucket. You can filter these out using `WHERE author_id IS NOT NULL` before the `GROUP BY`._

## Filtering Grouped Data (`HAVING`)

You use `WHERE` to filter rows _before_ they are grouped.
But what if you want to filter the results _after_ they are grouped and counted? You use the `HAVING` clause.

```sql
-- Only show authors who have written MORE THAN 1 post
SELECT author_id, COUNT(*) as total_posts
FROM posts
GROUP BY author_id
HAVING COUNT(*) > 1;
```
