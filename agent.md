# Agent Tracking - PostgreSQL Learning Journey

This document serves as a state tracker for AI agents assisting with this repository. It records what has been taught, what is currently being worked on, and what remains.

## Progress Overview

- [x] **01-basics.md**: Introduction, Docker setup, `psql` connections.
- [x] **02-databases-and-schemas.md**: Databases, Schemas (`public` vs custom).
- [x] **03-tables-and-data-types.md**: `CREATE TABLE`, `TEXT` vs `VARCHAR`, `TIMESTAMPTZ`, Identity columns.
- [x] **04-crud.md**: `INSERT`, `SELECT`, `UPDATE`, `DELETE`, `RETURNING`, `ON CONFLICT` (UPSERT).
- [x] **05-constraints.md**: `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT`.
- [x] **06-relationships.md**: Foreign Keys and referential integrity.
- [x] **07-select-and-filtering.md**: `LIKE`, `ILIKE`, `IN`, `BETWEEN`, `LIMIT`, `OFFSET`.
- [x] **08-joins.md**: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN`.
- [x] **09-aggregation.md**: `COUNT`, `GROUP BY`, `HAVING`.
- [x] **10-subqueries-and-cte.md**: Nested `WHERE IN` queries and `WITH` CTEs.
- [x] **11-advanced-sql.md**: Window Functions (`OVER`, `PARTITION BY`).
- [x] **12-postgresql-specific.md**: JSON/JSONB, Arrays, ENUMs.
- [x] **13-indexes-and-performance.md**: `EXPLAIN ANALYZE`, B-Tree indexes, Query Planner.
- [x] **14-transactions.md**: `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `FOR UPDATE`.
- [x] **15-users-and-permissions.md**: Roles, `GRANT`, `REVOKE`, Row-Level Security (RLS).
- [x] **16-backup-and-restore.md**: `pg_dump`, `pg_restore`.
- [ ] **17-postgresql-with-prisma.md**: ORM integration.
- [ ] **cheatsheet.md**: Final quick reference guide.

## Current State

- **Current Topic**: PostgreSQL with Prisma.
- **Next Topic**: Cheatsheet.
- **Database State**: PostgreSQL 16 running in Docker (`pg_learning`), database `learning_db`.
- **Current Tables**: `authors` (id, name), `posts` (id, title, content, published_at, author_id).
