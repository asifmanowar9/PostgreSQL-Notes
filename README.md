# PostgreSQL Learning & Documentation

Welcome to your personal PostgreSQL documentation! This repository will serve as both your learning curriculum and your future reference guide for "raw" PostgreSQL.

## Proposed Curriculum

We can cover the following topics step-by-step. As we learn each topic, we will add detailed notes and code examples to this documentation.

1. **Introduction & Setup**
   - Installing PostgreSQL and `psql` (the command-line client)
   - Basic architecture (Clusters, Databases, Schemas, Roles)
   - Connecting to a database

2. **Data Definition Language (DDL)**
   - Creating, altering, and dropping databases and schemas
   - Creating tables and choosing the right data types
   - Primary keys, foreign keys, and constraints

3. **Data Manipulation Language (DML)**
   - `INSERT`: Adding new data
   - `SELECT`: Querying data (filtering with `WHERE`, sorting with `ORDER BY`)
   - `UPDATE`: Modifying existing data
   - `DELETE`: Removing data

4. **Advanced Querying**
   - `JOIN`s (INNER, LEFT, RIGHT, FULL)
   - Aggregation (`GROUP BY`, `HAVING`, `SUM`, `AVG`, `COUNT`)
   - Subqueries and Common Table Expressions (CTEs / `WITH` clauses)
   - Window functions (`OVER`, `PARTITION BY`)

5. **Performance & Maintenance**
   - Indexes (B-Tree, Hash, GIN, GiST)
   - `EXPLAIN` and `EXPLAIN ANALYZE` for query optimization
   - Transactions and concurrency (`BEGIN`, `COMMIT`, `ROLLBACK`, Isolation Levels)
   - Backups and Restores (`pg_dump`, `pg_restore`)

6. **Advanced PostgreSQL Features**
   - JSON/JSONB data types and querying
   - Triggers and Stored Procedures (PL/pgSQL)
   - Views and Materialized Views

---

_This documentation is meant to be a living document. We will populate folders and markdown files for each of these topics as we go!_
