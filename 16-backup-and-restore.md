# 16 Backup And Restore

No matter how optimized or secure your database is, data loss can still happen. Routine backups are the ultimate safety net.

## Exporting Data (`pg_dump`)

`pg_dump` is a command-line tool that takes a snapshot of your database and exports it. By default, it exports it as a plain-text file full of standard SQL commands (`CREATE TABLE`, `INSERT`, etc.).

```bash
# Basic export
pg_dump -U myuser -d learning_db > backup.sql

# Export with "clean" commands (includes DROP TABLE before CREATE TABLE)
pg_dump -U myuser -d learning_db -c > clean_backup.sql
```

_(If you are running PostgreSQL inside Docker, you must run this command using `docker exec` and pipe the output to your host machine)._

## Restoring Data (`psql`)

Because the default `pg_dump` output is just a giant SQL script, restoring it is as simple as feeding that file directly back into the `psql` command-line tool.

```bash
# Feed the backup.sql file into the database
psql -U myuser -d learning_db < backup.sql
```

_(Notice the `<` arrow. You are redirecting the file into the `psql` command)._

### Binary Backups (`pg_restore`)

For massive databases (hundreds of gigabytes), plain-text SQL files are too slow. You can tell `pg_dump` to output a compressed custom binary format using the `-Fc` flag. To restore a binary format, you cannot use `psql`; you must use the `pg_restore` command instead.
