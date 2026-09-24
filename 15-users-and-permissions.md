# 15 Users And Permissions

When your database goes into production, your application should NEVER connect as the superuser. If a vulnerability is found in your app, a hacker with superuser access can drop your entire database.

Instead, you use Roles and the **Principle of Least Privilege**.

## Roles and Grants

You create specific roles (users) and grant them exact permissions to specific tables.

```sql
-- Create a new user that can log in
CREATE ROLE app_user WITH LOGIN PASSWORD 'securepassword123';

-- Give them permission to connect to the database
GRANT CONNECT ON DATABASE learning_db TO app_user;

-- Give them permission to read and insert posts, but FORBID them from deleting or updating
GRANT SELECT, INSERT ON TABLE posts TO app_user;
```

_(Note: When you log in as a restricted user via `psql`, your prompt will end in `=>` instead of the superuser's `=#`)._

## Row Level Security (RLS)

Permissions like `GRANT SELECT` apply to the entire table. If `app_user` can read the `posts` table, they can read _every_ post.

If you are building a multi-tenant app where users can only see their own data, you can enable **Row Level Security (RLS)**. This attaches an invisible SQL firewall to the table that runs on every query.

```sql
-- Step 1: Turn on the firewall for the table
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- Step 2: Write a policy determining who can see what.
-- This policy states that app_user can only select rows if a certain condition is met.
CREATE POLICY restrict_post_access ON posts
    FOR SELECT
    TO app_user
    USING (current_user = 'Asif');
```
