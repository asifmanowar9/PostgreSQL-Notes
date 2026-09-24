# 14 Transactions

Transactions ensure that your database remains in a valid state even if your application crashes halfway through a multi-step process. This is the foundation of ACID compliance.

## Basic Transactions (`BEGIN`, `COMMIT`, `ROLLBACK`)

By wrapping multiple SQL queries in a transaction block, you guarantee that either **all** of the queries succeed, or **none** of them do.

```sql
BEGIN;

-- Deduct $100 from Alice
UPDATE accounts SET balance = balance - 100 WHERE name = 'Alice';
-- Add $100 to Bob
UPDATE accounts SET balance = balance + 100 WHERE name = 'Bob';

-- If both succeeded without application errors, save them permanently:
COMMIT;

-- If something crashed, undo everything:
-- ROLLBACK;
```

---

## Advanced Transactions: Deep Dive

### 1. Partial Rollbacks (`SAVEPOINT`)

If you are running a massive batch script (e.g., importing 10,000 rows), and row 9,999 fails, a standard `ROLLBACK` destroys all the good work you did.

By creating a `SAVEPOINT`, you act like you are dropping an anchor. If something goes wrong, you can rollback _only_ to the anchor, preserving the work done before it.

```sql
BEGIN;

INSERT INTO authors (name) VALUES ('Good Data');

-- Drop an anchor here
SAVEPOINT safe_place;

INSERT INTO authors (name) VALUES ('Bad Data');

-- Undo ONLY the 'Bad Data' insert, keeping 'Good Data' intact
ROLLBACK TO SAVEPOINT safe_place;

COMMIT;
```

### 2. Row-Level Locking (`FOR UPDATE`)

Transactions also prevent **Race Conditions**. If two users try to buy the last concert ticket at the exact same millisecond, they might both read that there is 1 ticket left, and both deduct a ticket, leaving you with `-1` tickets.

To prevent this, you can append `FOR UPDATE` to a `SELECT` query. This physically locks the specific rows you queried. If a second user tries to run a query that affects those rows, their query will pause and wait until your transaction runs `COMMIT`.

```sql
BEGIN;

-- Lock the ticket row so no one else can read or modify it until we are done
SELECT tickets_left FROM events WHERE id = 1 FOR UPDATE;

-- Safely deduct the ticket
UPDATE events SET tickets_left = tickets_left - 1 WHERE id = 1;

-- Release the lock
COMMIT;
```
