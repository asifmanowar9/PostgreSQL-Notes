# 13 Indexes And Performance

When an application starts getting slow, the database is almost always the bottleneck. PostgreSQL provides built-in tools to diagnose and fix these performance issues.

## The Query Planner & `EXPLAIN ANALYZE`

When you send a query, PostgreSQL doesn't just run it blindly. The Query Planner looks at statistics about your tables and decides the fastest possible path to get your data.

You can view this plan using `EXPLAIN ANALYZE`:

```sql
EXPLAIN ANALYZE SELECT * FROM posts WHERE title = 'A post by Bob';
```

### Sequential Scans (`Seq Scan`)

This is the default method for searching. PostgreSQL starts at row 1 and reads every single row until it reaches the end of the table. For a table with 10 million rows, this is extremely slow.

## Indexes

An Index is a separate data structure (usually a B-Tree) that PostgreSQL builds in the background. It keeps a sorted list of the column you specify, allowing the database to instantly jump to the correct row instead of scanning the whole table.

```sql
-- Creating an index on the title column
CREATE INDEX idx_post_title ON posts(title);
```

### The Query Planner is Smart!

If you create an index on a table that only has a few rows, PostgreSQL will often **ignore the index** and continue doing a `Seq Scan`. This is because reading an index and then fetching the row takes more disk operations than simply reading 10 rows directly from the table.

As the table grows to thousands of rows, the Query Planner will automatically switch from `Seq Scan` to `Index Scan`.

_(If you ever need to force an Index Scan for testing purposes, you can run `SET enable_seqscan = OFF;` in your session)._

---

## Advanced Indexing Strategies

Standard B-Tree indexes on single columns are just the beginning. To truly optimize a database, you need specialized indexes.

### 1. Partial Indexes (Saving RAM and Disk Space)

Every index takes up space on your hard drive and in RAM. If you only ever query a specific subset of data (e.g., you only query "published" posts, never "drafts"), you can add a `WHERE` clause to the index itself. This keeps the index tiny and lightning fast.

```sql
-- This index completely ignores drafts and archived posts
CREATE INDEX idx_published_posts ON posts(published_at) WHERE status = 'published';
```

### 2. Composite (Multi-Column) Indexes

When your queries frequently filter by multiple columns at the same time (`WHERE author_id = 1 AND published_at > '2026-01-01'`), a single composite index is much faster than two separate single-column indexes.

```sql
CREATE INDEX idx_author_and_date ON posts(author_id, published_at);
```

_(Pro-tip: Order matters. Place columns used for exact equality checks (`=`) first, and columns used for ranges (`>`) second)._

### 3. GIN Indexes (For JSONB and Arrays)

A standard B-Tree index cannot look "inside" an Array or a JSONB object. If you want to query for a specific key inside your JSON metadata without doing a Sequential Scan, you must use a Generalized Inverted Index (`GIN`).

```sql
-- "USING GIN" tells PostgreSQL to index the internal structure of the JSON/Array
CREATE INDEX idx_gin_metadata ON posts USING GIN (metadata);
```
