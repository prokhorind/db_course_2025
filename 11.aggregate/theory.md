# Aggregate Functions in PostgreSQL - Theory

## What are Aggregate Functions?

Aggregate functions perform calculations on multiple rows of data and return a single result. They are essential for data analysis, reporting, and understanding patterns in your database.

Think of it like this: if you have a list of numbers, an aggregate function can tell you the sum, average, or count of those numbers in one operation.

## Common Aggregate Functions

### 1. COUNT()
Counts the number of rows.

```sql
-- Count all rows
SELECT COUNT(*) FROM planets;

-- Count non-NULL values in a specific column
SELECT COUNT(discovery_year) FROM planets;
```

**Use cases:** How many records exist? How many customers made purchases?

### 2. SUM()
Adds up all values in a numeric column.

```sql
SELECT SUM(number_of_moons) FROM planets;
```

**Use cases:** Total sales, total inventory, sum of all transactions.

### 3. AVG()
Calculates the average (mean) of numeric values.

```sql
SELECT AVG(diameter_km) FROM planets;
```

**Use cases:** Average price, average age, average rating.

### 4. MIN() and MAX()
Finds the minimum or maximum value.

```sql
SELECT MIN(distance_from_sun_million_km), 
       MAX(distance_from_sun_million_km) 
FROM planets;
```

**Use cases:** Earliest date, highest score, lowest price, oldest customer.

### 5. STRING_AGG()
Concatenates text values into a single string (PostgreSQL specific).

```sql
SELECT STRING_AGG(name, ', ') FROM planets;
```

**Use cases:** Creating comma-separated lists, combining multiple values.

## GROUP BY Clause

GROUP BY divides rows into groups based on one or more columns. Aggregate functions then calculate results for each group separately.

### Basic Syntax

```sql
SELECT column_name, AGGREGATE_FUNCTION(column_name)
FROM table_name
GROUP BY column_name;
```

### Example

```sql
-- Count planets by type
SELECT planet_type, COUNT(*) AS planet_count
FROM planets
GROUP BY planet_type;
```

**Result:**
```
planet_type  | planet_count
-------------|-------------
terrestrial  | 4
gas_giant    | 2
ice_giant    | 2
```

### Important Rules

1. **Every column in SELECT must be either:**
   - In the GROUP BY clause, OR
   - Inside an aggregate function

2. **This is WRONG:**
   ```sql
   SELECT name, planet_type, COUNT(*)
   FROM planets
   GROUP BY planet_type;  -- ERROR: name is not grouped or aggregated
   ```

3. **This is CORRECT:**
   ```sql
   SELECT planet_type, COUNT(*) AS planet_count
   FROM planets
   GROUP BY planet_type;
   ```

### Multiple Column Grouping

You can group by multiple columns to create more specific categories:

```sql
SELECT planet_type, has_rings, COUNT(*) AS planet_count
FROM planets
GROUP BY planet_type, has_rings;
```

This creates a separate group for each unique combination of planet_type and has_rings.

## HAVING Clause

HAVING filters groups after aggregation. It's like WHERE, but for groups instead of individual rows.

### WHERE vs HAVING

- **WHERE:** Filters individual rows BEFORE grouping
- **HAVING:** Filters groups AFTER aggregation

### Example

```sql
-- Show only planet types with more than 2 planets
SELECT planet_type, COUNT(*) AS planet_count
FROM planets
GROUP BY planet_type
HAVING COUNT(*) > 2;
```

### When to Use Each

```sql
-- CORRECT: Use WHERE to filter rows before grouping
SELECT planet_type, AVG(diameter_km) AS avg_diameter
FROM planets
WHERE has_rings = TRUE  -- Filter rows first
GROUP BY planet_type
HAVING AVG(diameter_km) > 50000;  -- Filter groups after

-- WRONG: Can't use WHERE on aggregate results
SELECT planet_type, AVG(diameter_km) AS avg_diameter
FROM planets
WHERE AVG(diameter_km) > 50000  -- ERROR!
GROUP BY planet_type;
```

## Query Execution Order

Understanding the order helps you write correct queries:

1. **FROM** - Get data from table
2. **WHERE** - Filter individual rows
3. **GROUP BY** - Create groups
4. **Aggregate Functions** - Calculate results for each group
5. **HAVING** - Filter groups
6. **SELECT** - Choose columns to display
7. **ORDER BY** - Sort results

### Example with All Clauses

```sql
SELECT planet_type, 
       COUNT(*) AS planet_count,
       AVG(mass_earth_units) AS avg_mass
FROM planets
WHERE distance_from_sun_million_km > 200  -- 1. Filter rows
GROUP BY planet_type                       -- 2. Create groups
HAVING AVG(mass_earth_units) > 1          -- 3. Filter groups
ORDER BY avg_mass DESC;                    -- 4. Sort results
```

## Advanced Techniques

### Using CASE with GROUP BY

Create custom categories on the fly:

```sql
SELECT 
    CASE 
        WHEN diameter_km < 10000 THEN 'Small'
        WHEN diameter_km < 50000 THEN 'Medium'
        ELSE 'Large'
    END AS size_category,
    COUNT(*) AS planet_count
FROM planets
GROUP BY size_category;
```

### Subqueries with Aggregates

Calculate percentages or compare to overall averages:

```sql
-- What percentage of total moons does each planet type have?
SELECT 
    planet_type,
    SUM(number_of_moons) AS type_moons,
    ROUND(100.0 * SUM(number_of_moons) / 
          (SELECT SUM(number_of_moons) FROM planets), 2) AS percentage
FROM planets
GROUP BY planet_type;
```

## Common Mistakes to Avoid

### 1. Forgetting GROUP BY

```sql
-- WRONG: Can't mix aggregates and regular columns without GROUP BY
SELECT planet_type, COUNT(*)
FROM planets;

-- CORRECT:
SELECT planet_type, COUNT(*)
FROM planets
GROUP BY planet_type;
```

### 2. Using WHERE Instead of HAVING

```sql
-- WRONG: Can't use aggregate in WHERE
SELECT planet_type, AVG(diameter_km)
FROM planets
WHERE AVG(diameter_km) > 10000
GROUP BY planet_type;

-- CORRECT: Use HAVING for aggregate conditions
SELECT planet_type, AVG(diameter_km)
FROM planets
GROUP BY planet_type
HAVING AVG(diameter_km) > 10000;
```

### 3. Selecting Non-Grouped Columns

```sql
-- WRONG: name is not grouped or aggregated
SELECT name, planet_type, COUNT(*)
FROM planets
GROUP BY planet_type;

-- CORRECT: Either group by name or use an aggregate
SELECT planet_type, COUNT(*) AS planet_count
FROM planets
GROUP BY planet_type;
```

## Practical Tips

1. **Start Simple:** Begin with basic aggregates on the whole table, then add GROUP BY.

2. **Test Step by Step:** 
   - First, write the query without GROUP BY
   - Add GROUP BY and test
   - Add HAVING if needed
   - Finally add ORDER BY

3. **Use Aliases:** Make your results readable with AS:
   ```sql
   SELECT COUNT(*) AS total_planets  -- Much clearer than just COUNT(*)
   ```

4. **ROUND() for Decimals:** Use ROUND() to make averages more readable:
   ```sql
   SELECT ROUND(AVG(diameter_km), 2) AS avg_diameter
   ```

5. **Comment Your Queries:** Especially for complex aggregations, explain what you're calculating.

## Real-World Applications

- **Sales Reports:** Total sales by region, average order value by customer type
- **Analytics:** User engagement metrics, conversion rates by channel
- **Inventory:** Stock levels by warehouse, average product ratings by category
- **HR:** Employee count by department, average salary by position
- **Science:** Statistical analysis, data summarization, pattern detection

## Practice Strategy

1. Master basic aggregates (COUNT, SUM, AVG, MIN, MAX)
2. Learn GROUP BY with single columns
3. Add HAVING to filter groups
4. Combine WHERE, GROUP BY, and HAVING
5. Practice with multiple grouping columns
6. Explore advanced techniques (CASE, subqueries)

Remember: Aggregate functions are powerful tools for turning raw data into meaningful insights!
