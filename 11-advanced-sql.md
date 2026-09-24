# 11 Advanced SQL

## Window Functions

Unlike regular aggregate functions (which squash rows together using `GROUP BY`), a Window Function performs a calculation across a set of related rows but **retains the individual rows** in the output.

### Syntax: `OVER` and `PARTITION BY`

To use a window function, you use the `OVER()` keyword. Inside the parentheses, you define the "window" of rows you want to look at using `PARTITION BY` (similar to `GROUP BY`, but without squashing).

### Example: Chronological Numbering (`ROW_NUMBER`)

If we want to list every single post, but also include a column that numbers the posts chronologically _for each specific author_, we can use the `ROW_NUMBER()` window function:

```sql
SELECT
    title,
    author_id,
    ROW_NUMBER() OVER(
        PARTITION BY author_id     -- Reset the count for each new author
        ORDER BY published_at ASC  -- Number them chronologically based on time
    ) as post_number
FROM posts
WHERE author_id IS NOT NULL;
```

---

## Advanced Window Functions

### `LAG()` and `LEAD()`

Allows you to compare the current row to the previous row (`LAG`) or the next row (`LEAD`) within the window. This is extremely powerful for calculating day-over-day changes or time elapsed between events.

```sql
SELECT
    title,
    published_at,
    LAG(published_at) OVER (
        PARTITION BY author_id
        ORDER BY published_at ASC
    ) as previous_post_date
FROM posts
WHERE author_id = 1;
```

### Cumulative Aggregations (`SUM() OVER`)

You can turn standard aggregate functions (like `SUM` or `AVG`) into running totals or running averages by appending an `OVER` clause with an `ORDER BY`.

```sql
-- Creates a running total of views for an author
SELECT
    title,
    10 as views_for_this_post,
    SUM(10) OVER (
        PARTITION BY author_id
        ORDER BY published_at ASC, id ASC -- id ASC is the tie-breaker
    ) as running_total_views
FROM posts
WHERE author_id = 1;
```

**⚠️ Warning on Ties (Peers):**
If two rows have the exact same value in the `ORDER BY` clause (like two posts created at the exact same millisecond), PostgreSQL considers them "peers". By default, running aggregations evaluate peers simultaneously, meaning it will sum both of their values at the exact same time resulting in a jump (e.g., 10, 30, 30 instead of 10, 20, 30).

**The Fix:** Always add a unique column to your `ORDER BY` (like `, id ASC`) to guarantee a deterministic order and break ties.
