# 17 Postgresql With Prisma

While knowing raw SQL is essential for debugging and performance tuning, modern application development heavily relies on Object-Relational Mappers (ORMs) like **Prisma** (for Node.js/TypeScript).

ORMs act as a bridge between your application code and your PostgreSQL database. They generate the raw SQL queries for you based on the methods you call in your code.

## Why Use Prisma with PostgreSQL?

1. **Type Safety**: Prisma reads your database schema and generates strict TypeScript types. If you try to insert a string into an integer column, your code will fail to compile.
2. **Migrations**: Instead of manually writing `ALTER TABLE` statements, you define your desired table structure in a `schema.prisma` file, and Prisma automatically writes and executes the necessary SQL to make your database match your file.
3. **Native PostgreSQL Support**: Prisma natively supports PostgreSQL-specific features like `JSONB`, `Arrays`, and `ENUMs`.

## Example Prisma Schema

This is how the `learning_db` database we built using raw SQL translates into a Prisma Schema:

```prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL") // e.g., postgresql://myuser:mypassword@localhost:5432/learning_db
}

generator client {
  provider = "prisma-client-js"
}

model Author {
  id    Int    @id @default(autoincrement())
  name  String
  posts Post[] // Defines the one-to-many relationship
}

model Post {
  id           Int       @id @default(autoincrement())
  title        String
  content      String?   // The '?' indicates this column allows NULL
  published_at DateTime  @default(now()) @db.Timestamptz

  author_id    Int?
  author       Author?   @relation(fields: [author_id], references: [id])

  tags         String[]  // Maps directly to PostgreSQL TEXT[]
  metadata     Json?     // Maps directly to PostgreSQL JSONB
  status       PostStatus @default(DRAFT) // Maps to our custom ENUM
}

enum PostStatus {
  DRAFT
  PUBLISHED
  ARCHIVED
}
```

## Example Prisma Client Query

Instead of writing `SELECT * FROM posts WHERE author_id = 1`, you write JavaScript/TypeScript:

```typescript
const postsByAsif = await prisma.post.findMany({
  where: {
    author_id: 1,
  },
  include: {
    author: true, // Automatically performs a LEFT JOIN on the Author table!
  },
});
```
