# 01 - Introduction and Setup

## Running PostgreSQL in Docker

Using Docker is an excellent way to run PostgreSQL without cluttering your host system. We use a `docker-compose.yml` file to define our database service.

### The `docker-compose.yml` File

```yaml
version: "3.8"

services:
  postgres:
    image: postgres:16
    container_name: pg_learning
    environment:
      POSTGRES_USER: myuser # The superuser name
      POSTGRES_PASSWORD: mypassword # The superuser password
      POSTGRES_DB: learning_db # The default database created on startup
    ports:
      - "5432:5432" # Maps container port 5432 to host port 5432
    volumes:
      - pg_data:/var/lib/postgresql/data # Persists data even if the container is removed

volumes:
  pg_data:
```

**To start the database:**

```bash
docker compose up -d
```

_(The `-d` flag runs the container in the background, freeing up your terminal)._

**To stop the database (without losing data):**

```bash
docker compose stop
```

**To completely remove the container and the data volume:**

```bash
docker compose down -v
```

---

## Connecting with `psql`

`psql` is the interactive terminal for working with PostgreSQL. It comes pre-installed inside the official PostgreSQL Docker image.

To connect to your database using the container, run:

```bash
docker exec -it pg_learning psql -U myuser -d learning_db
```

- `docker exec -it pg_learning`: Tells Docker to run an interactive terminal command inside the `pg_learning` container.
- `psql`: The command-line client we are invoking.
- `-U myuser`: Connects as the user `myuser`.
- `-d learning_db`: Connects to the database `learning_db`.

### Helpful `psql` Meta-commands

Commands in `psql` that start with a backslash `\` are meta-commands used to interact with the client or database system itself (not standard SQL).

| Command         | Description                                                 |
| :-------------- | :---------------------------------------------------------- |
| `\q`            | Quit `psql`                                                 |
| `\conninfo`     | Display information about your current connection           |
| `\l`            | List all databases                                          |
| `\dt`           | List all tables in the current database                     |
| `\d table_name` | Describe a specific table (shows columns, types, modifiers) |
| `\?`            | Show help for meta-commands                                 |
