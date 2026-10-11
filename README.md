# PostgreSQL Learning & Documentation

Welcome to your personal PostgreSQL documentation! This repository serves as your comprehensive, custom-built reference guide for "raw" PostgreSQL..

## Documentation Index

The curriculum is structured into the following topics. Check `agent.md` to see the current progress and learning state.

### Core Concepts

- [01 Basics](01-basics.md) - Docker setup, `psql`, and connections.
- [02 Databases and Schemas](02-databases-and-schemas.md) - Logical database structures.
- [03 Tables and Data Types](03-tables-and-data-types.md) - `CREATE TABLE`, `TEXT`, `TIMESTAMPTZ`, Identities.
- [04 CRUD](04-crud.md) - `INSERT`, `SELECT`, `UPDATE`, `DELETE`, `RETURNING`, `ON CONFLICT`.
- [05 Constraints](05-constraints.md) - Enforcing rules (`UNIQUE`, `CHECK`, `NOT NULL`).

### Querying & Relations

- [06 Relationships](06-relationships.md) - Foreign Keys and referential integrity.
- [07 Select and Filtering](07-select-and-filtering.md) - `LIKE`, `IN`, `BETWEEN`, Limits.
- [08 Joins](08-joins.md) - `INNER`, `LEFT`, `RIGHT`, and `FULL` joins.
- [09 Aggregation](09-aggregation.md) - `COUNT`, `GROUP BY`, `HAVING`.
- [10 Subqueries and CTE](10-subqueries-and-cte.md) - Nested queries and the `WITH` clause.
- [11 Advanced SQL](11-advanced-sql.md) - Window Functions (`OVER`, `PARTITION BY`).

### PostgreSQL Specifics & Operations

- [12 PostgreSQL Specific](12-postgresql-specific.md) - JSONB, Arrays, ENUMs.
- [13 Indexes and Performance](13-indexes-and-performance.md) - `EXPLAIN ANALYZE` and B-Trees.
- [14 Transactions](14-transactions.md) - ACID, `BEGIN`, `COMMIT`, `ROLLBACK`.
- [15 Users and Permissions](15-users-and-permissions.md) - Roles, `GRANT`, `REVOKE`.
- [16 Backup and Restore](16-backup-and-restore.md) - `pg_dump`, `pg_restore`.
- [17 PostgreSQL with Prisma](17-postgresql-with-prisma.md) - Connecting to modern ORMs.

---

**Quick Reference:**

- [Cheatsheet](cheatsheet.md) - Fast reference for common commands.
- [Agent State](agent.md) - Progress tracker for AI assistants.
