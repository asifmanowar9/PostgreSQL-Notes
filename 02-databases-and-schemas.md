# 02 Databases And Schemas

PostgreSQL uses a hierarchical structure to organize data.

1. **Cluster:** The entire PostgreSQL server running on your machine (or in your Docker container).
2. **Database:** An isolated collection of data. Databases cannot easily communicate with each other.
3. **Schema:** A logical folder _inside_ a database used to organize tables and prevent name collisions.

## Managing Databases

To create a new, empty database:

```sql
CREATE DATABASE my_new_db;
```

To switch to a different database using the `psql` command-line tool, use the `\c` (connect) meta-command:

```sql
\c my_new_db
```

## Managing Schemas

By default, every database has a schema named `public`. If you run `CREATE TABLE posts...`, PostgreSQL automatically puts it in `public.posts`.

To organize your data better, you can create custom schemas:

```sql
CREATE SCHEMA store;
```

To create a table inside a specific schema, use dot-notation:

```sql
CREATE TABLE store.products (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT
);
```

### Viewing Schema Tables in `psql`

The `\dt` command only lists tables in the `public` schema by default.
To view tables inside a specific schema, you must specify the schema name:

```sql
\dt store.*
```
