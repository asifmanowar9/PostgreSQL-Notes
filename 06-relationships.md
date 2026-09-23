# 06 Relationships

## Foreign Keys & Relations

To link data across tables, PostgreSQL uses Foreign Keys. This guarantees **referential integrity**—meaning the database will throw an error if you try to assign a post to an author ID that does not exist.

```sql
-- Linking the 'posts' table to the 'authors' table
ALTER TABLE posts ADD COLUMN author_id INT REFERENCES authors(id);
```
