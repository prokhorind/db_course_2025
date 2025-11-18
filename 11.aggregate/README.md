# Aggregate Functions in PostgreSQL

This folder contains examples demonstrating aggregate functions, GROUP BY, and HAVING clauses using a solar system planets theme.

## Files

- **schema.sql** - Creates the `solar_system` schema and `planets` table
- **data.sql** - Inserts data for 8 planets in our solar system
- **queries.sql** - 22 examples from basic to advanced aggregate queries

## Setup Instructions

1. Run the schema file to create the database structure:
```sql
\i 11.aggregate/schema.sql
```

2. Insert the planet data:
```sql
\i 11.aggregate/data.sql
```

3. Practice with the queries:
```sql
\i 11.aggregate/queries.sql
```

## Topics Covered

### Basic Aggregate Functions
- `COUNT()` - Count rows
- `SUM()` - Sum values
- `AVG()` - Calculate average
- `MIN()` / `MAX()` - Find minimum/maximum values

### GROUP BY
- Single column grouping
- Multiple column grouping
- Combining with ORDER BY

### HAVING Clause
- Filtering grouped results
- Combining WHERE, GROUP BY, and HAVING

### Advanced Topics
- Aggregates with CASE expressions
- Subqueries in SELECT with aggregates
- STRING_AGG for concatenation
- Percentage calculations

## Query Progression

The queries are ordered from easiest to hardest:
- Queries 1-5: Basic aggregates without grouping
- Queries 6-11: GROUP BY with single column
- Queries 12-14: HAVING clause basics
- Queries 15-17: Combining WHERE, GROUP BY, and HAVING
- Queries 18-20: Advanced grouping and CASE expressions
- Queries 21-22: Expert level with subqueries and comparisons
