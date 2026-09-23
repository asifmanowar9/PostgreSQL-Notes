# 03 Tables And Data Types

# 02 - Data Definition Language (DDL)

DDL is used to define database structures like schemas and tables.

## PostgreSQL Data Types and Best Practices

When creating tables in PostgreSQL, there are a few modern best practices to follow compared to standard or legacy SQL.

### 1. Auto-incrementing Primary Keys

Historically, PostgreSQL used the `SERIAL` pseudo-type for auto-incrementing IDs.
Starting from Postgres 10, the SQL-standard `GENERATED ALWAYS AS IDENTITY` is the recommended way. It prevents users from manually inserting an ID value and accidentally throwing the internal counter out of sync.

### 2. Strings

PostgreSQL has three main string types: `CHAR(n)`, `VARCHAR(n)`, and `TEXT`.
Under the hood, PostgreSQL handles `VARCHAR(n)` and `TEXT` almost identically in terms of performance. The community standard is to just use **`TEXT`** for strings. Only use `VARCHAR(n)` if you specifically want the database to enforce a strict character limit at the database level.

### 3. Dates and Times

Always use **`TIMESTAMPTZ`** (Timestamp with Time Zone) instead of `TIMESTAMP`. It ensures that Postgres properly converts and stores the time in UTC, which avoids massive headaches when dealing with users in different timezones.

---

## Example: Creating a Table

Here is the code we used to create our `posts` table using these best practices:

```sql
CREATE TABLE posts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT,
    published_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
```

### Modifying Tables (`ALTER`)

If you need to change a table after it's created, you use the `ALTER TABLE` command.

_Example: Adding a new column_

```sql
ALTER TABLE posts ADD COLUMN author_name TEXT;
```

_Example: Removing a column_

```sql
ALTER TABLE posts DROP COLUMN author_name;
```
