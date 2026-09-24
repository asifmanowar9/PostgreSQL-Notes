# 05 Constraints

A database is only as good as the data inside it. Constraints are strict rules you apply to columns to force the database to reject invalid data, preventing application bugs at the data layer.

## Common Constraints

1. **`PRIMARY KEY`**: Uniquely identifies a row. (Automatically implies `UNIQUE` and `NOT NULL`).
2. **`FOREIGN KEY` (`REFERENCES`)**: Ensures the value exists in another table's column (referential integrity).
3. **`NOT NULL`**: Prevents a column from being left blank (`NULL`).
4. **`DEFAULT`**: Automatically inserts a specified value if none is provided during an `INSERT`. (e.g., `DEFAULT CURRENT_TIMESTAMP`).

## Data Integrity Constraints

### `UNIQUE`

Guarantees that no two rows can have the same value in a column. This is essential for things like usernames or email addresses.

```sql
-- Creating a table with a UNIQUE constraint
CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email TEXT UNIQUE NOT NULL
);

-- Adding a UNIQUE constraint to an existing table
ALTER TABLE store.products ADD CONSTRAINT unique_product_name UNIQUE (name);
```

### `CHECK`

Allows you to define a custom mathematical or logical rule that the data must pass before it is inserted or updated. If the condition evaluates to `false`, the database throws an error.

```sql
-- Creating a table with a CHECK constraint
CREATE TABLE users (
    age INT CHECK (age >= 18)
);

-- Adding a CHECK constraint to an existing table
ALTER TABLE store.products ADD COLUMN price DECIMAL CHECK (price > 0);
```

If an application attempts to run `INSERT INTO store.products (name, price) VALUES ('Bad Apple', 0);`, PostgreSQL will aggressively block it with a `violates check constraint` error, protecting your data integrity.
