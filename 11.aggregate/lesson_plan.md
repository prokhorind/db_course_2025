# Lesson Plan: Aggregate Functions in PostgreSQL

## Course Information
- **Topic:** Aggregate Functions, GROUP BY, and HAVING
- **Duration:** 90-120 minutes
- **Level:** Beginner to Intermediate
- **Prerequisites:** Basic SQL (SELECT, WHERE, ORDER BY)

## Learning Objectives

By the end of this lesson, students will be able to:
1. Use the five main aggregate functions (COUNT, SUM, AVG, MIN, MAX)
2. Group data using GROUP BY clause
3. Filter grouped data with HAVING clause
4. Understand the difference between WHERE and HAVING
5. Combine multiple aggregate functions in complex queries
6. Apply aggregate functions to real-world data analysis problems

## Materials Needed
- PostgreSQL database access
- `schema.sql` - Database schema
- `data.sql` - Sample data (solar system planets)
- `queries.sql` - 22 example queries
- `theory.md` - Reference material
- Projector/screen for demonstrations

---

## Lesson Structure

### Part 1: Introduction (10 minutes)

#### Hook (3 minutes)
Ask students: "How would you answer these questions?"
- How many planets are in our solar system?
- What's the average size of a planet?
- Which type of planet has the most moons?

Explain that aggregate functions help us answer these "summary" questions.

#### Setup (7 minutes)
1. Have students run `schema.sql` to create the database
2. Run `data.sql` to insert planet data
3. Quick verification: `SELECT * FROM solar_system.planets;`
4. Show the 8 planets and their attributes

---

### Part 2: Basic Aggregate Functions (20 minutes)

#### COUNT() - 5 minutes
**Demonstrate:**
```sql
SELECT COUNT(*) AS total_planets FROM planets;
```

**Explain:**
- COUNT(*) counts all rows
- COUNT(column) counts non-NULL values
- Most basic aggregate function

**Student Exercise:**
"Count how many planets have rings"
```sql
SELECT COUNT(*) FROM planets WHERE has_rings = TRUE;
```

#### SUM() and AVG() - 7 minutes
**Demonstrate:**
```sql
-- Total moons
SELECT SUM(number_of_moons) AS total_moons FROM planets;

-- Average distance from sun
SELECT AVG(distance_from_sun_million_km) AS avg_distance FROM planets;
```

**Explain:**
- SUM adds up numeric values
- AVG calculates the mean
- Both ignore NULL values

**Student Exercise:**
"Find the average mass of all planets in Earth units"

#### MIN() and MAX() - 5 minutes
**Demonstrate:**
```sql
SELECT 
    MIN(diameter_km) AS smallest,
    MAX(diameter_km) AS largest
FROM planets;
```

**Student Exercise:**
"Find the closest and farthest planet from the Sun"

#### Multiple Aggregates - 3 minutes
**Demonstrate:**
```sql
SELECT 
    COUNT(*) AS total_planets,
    AVG(diameter_km) AS avg_diameter,
    SUM(number_of_moons) AS total_moons
FROM planets;
```

**Key Point:** You can use multiple aggregate functions in one query.

---

### Part 3: GROUP BY Clause (25 minutes)

#### Introduction to GROUP BY - 8 minutes
**Explain the Concept:**
- Without GROUP BY: aggregates work on ALL rows
- With GROUP BY: aggregates work on EACH group separately

**Visual Example on Board:**
Draw a table showing planets grouped by type:
```
terrestrial: Mercury, Venus, Earth, Mars (4 planets)
gas_giant: Jupiter, Saturn (2 planets)
ice_giant: Uranus, Neptune (2 planets)
```

**Demonstrate:**
```sql
SELECT planet_type, COUNT(*) AS planet_count
FROM planets
GROUP BY planet_type;
```

**Walk through the result** showing how COUNT works per group.

#### GROUP BY with Different Aggregates - 10 minutes
**Demonstrate progressively:**

1. Average diameter by type:
```sql
SELECT planet_type, AVG(diameter_km) AS avg_diameter
FROM planets
GROUP BY planet_type;
```

2. Total moons by type:
```sql
SELECT planet_type, SUM(number_of_moons) AS total_moons
FROM planets
GROUP BY planet_type;
```

3. Multiple aggregates:
```sql
SELECT 
    planet_type,
    COUNT(*) AS planet_count,
    AVG(diameter_km) AS avg_diameter,
    SUM(number_of_moons) AS total_moons
FROM planets
GROUP BY planet_type;
```

**Student Exercise (5 minutes):**
"Group planets by whether they have rings, and show the average number of moons for each group"

#### Common Mistake - 7 minutes
**Show the ERROR:**
```sql
SELECT name, planet_type, COUNT(*)
FROM planets
GROUP BY planet_type;
```

**Explain:**
- Every column in SELECT must be in GROUP BY or inside an aggregate
- This is the #1 mistake beginners make

**Show the Fix:**
```sql
SELECT planet_type, COUNT(*) AS planet_count
FROM planets
GROUP BY planet_type;
```

---

### Part 4: HAVING Clause (20 minutes)

#### WHERE vs HAVING - 10 minutes
**Draw on Board:**
```
Query Execution Order:
1. FROM → Get data
2. WHERE → Filter ROWS
3. GROUP BY → Create groups
4. HAVING → Filter GROUPS
5. SELECT → Choose columns
6. ORDER BY → Sort
```

**Demonstrate WHERE:**
```sql
SELECT planet_type, COUNT(*) AS planet_count
FROM planets
WHERE distance_from_sun_million_km > 200
GROUP BY planet_type;
```
Explain: WHERE filters rows BEFORE grouping.

**Demonstrate HAVING:**
```sql
SELECT planet_type, COUNT(*) AS planet_count
FROM planets
GROUP BY planet_type
HAVING COUNT(*) > 2;
```
Explain: HAVING filters groups AFTER aggregation.

**Show the ERROR:**
```sql
SELECT planet_type, AVG(diameter_km)
FROM planets
WHERE AVG(diameter_km) > 10000  -- ERROR!
GROUP BY planet_type;
```

**Explain:** Can't use aggregates in WHERE. Must use HAVING.

#### Combining WHERE and HAVING - 10 minutes
**Demonstrate:**
```sql
SELECT 
    planet_type,
    COUNT(*) AS planet_count,
    AVG(mass_earth_units) AS avg_mass
FROM planets
WHERE has_rings = TRUE           -- Filter rows first
GROUP BY planet_type
HAVING AVG(mass_earth_units) > 10;  -- Filter groups after
```

**Walk Through Step by Step:**
1. Start with all 8 planets
2. WHERE filters to 4 planets with rings
3. GROUP BY creates groups by type
4. Calculate AVG for each group
5. HAVING filters to groups with avg_mass > 10
6. Display results

**Student Exercise:**
"Find planet types where the average distance from the Sun is greater than 1000 million km, but only for planets discovered after 1700"

---

### Part 5: Advanced Techniques (20 minutes)

#### Multiple Column Grouping - 5 minutes
**Demonstrate:**
```sql
SELECT 
    planet_type,
    has_rings,
    COUNT(*) AS planet_count
FROM planets
GROUP BY planet_type, has_rings
ORDER BY planet_type, has_rings;
```

**Explain:** Creates a group for each unique combination.

#### CASE with GROUP BY - 8 minutes
**Demonstrate:**
```sql
SELECT 
    CASE 
        WHEN diameter_km < 10000 THEN 'Small'
        WHEN diameter_km < 50000 THEN 'Medium'
        ELSE 'Large'
    END AS size_category,
    COUNT(*) AS planet_count,
    AVG(number_of_moons) AS avg_moons
FROM planets
GROUP BY size_category;
```

**Explain:** CASE creates custom categories on the fly.

#### Subqueries and Percentages - 7 minutes
**Demonstrate:**
```sql
SELECT 
    planet_type,
    SUM(number_of_moons) AS type_moons,
    ROUND(100.0 * SUM(number_of_moons) / 
          (SELECT SUM(number_of_moons) FROM planets), 2) AS percentage
FROM planets
GROUP BY planet_type
ORDER BY type_moons DESC;
```

**Explain:** 
- Subquery calculates total moons
- Main query calculates percentage for each type
- Useful for "part of whole" analysis

---

### Part 6: Practice Session (20 minutes)

#### Guided Practice (10 minutes)
Work through queries 15-17 from `queries.sql` together:
- Query 15: WHERE + GROUP BY + HAVING combined
- Query 16: Working with NULL values
- Query 17: Complex filtering and ordering

#### Independent Practice (10 minutes)
Students work on these challenges:

**Challenge 1 (Easy):**
"Find the planet type with the highest average mass"

**Challenge 2 (Medium):**
"Show planet types that have at least one planet with more than 20 moons"

**Challenge 3 (Hard):**
"Create a report showing inner planets (< 300M km from sun) grouped by whether they have moons, with average diameter for each group"

---

### Part 7: Real-World Applications (10 minutes)

#### Discussion
Show how these concepts apply to real scenarios:

**E-commerce:**
```sql
-- Total sales by product category
SELECT category, SUM(sales_amount) AS total_sales
FROM orders
GROUP BY category
HAVING SUM(sales_amount) > 10000;
```

**Social Media:**
```sql
-- Average engagement by post type
SELECT post_type, AVG(likes + comments) AS avg_engagement
FROM posts
WHERE created_at > '2024-01-01'
GROUP BY post_type
ORDER BY avg_engagement DESC;
```

**Healthcare:**
```sql
-- Patient count by age group
SELECT 
    CASE 
        WHEN age < 18 THEN 'Child'
        WHEN age < 65 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    COUNT(*) AS patient_count
FROM patients
GROUP BY age_group;
```

---

### Part 8: Wrap-Up and Q&A (10 minutes)

#### Key Takeaways
Review the main points:
1. Aggregate functions summarize data (COUNT, SUM, AVG, MIN, MAX)
2. GROUP BY divides data into groups
3. HAVING filters groups (WHERE filters rows)
4. Execution order: WHERE → GROUP BY → HAVING
5. Every SELECT column must be grouped or aggregated

#### Common Pitfalls Reminder
- Don't forget GROUP BY when mixing aggregates and regular columns
- Use HAVING (not WHERE) for aggregate conditions
- Remember execution order

#### Q&A
Open floor for questions.

#### Homework Assignment
Provide students with additional exercises:
1. Work through all 22 queries in `queries.sql`
2. Write 5 original queries using the planets dataset
3. Think of a real-world dataset and write 3 aggregate queries for it

---

## Assessment Ideas

### Formative (During Class)
- Monitor student exercises
- Ask students to explain their queries
- Quick polls: "Which clause filters groups?"

### Summative (After Class)
- Quiz on aggregate functions and GROUP BY
- Practical exam: Write queries to answer specific questions
- Project: Analyze a dataset using aggregate functions

---

## Differentiation Strategies

### For Struggling Students
- Provide query templates with blanks to fill in
- Pair with stronger students
- Focus on mastering basic aggregates before GROUP BY
- Extra practice with visual diagrams

### For Advanced Students
- Challenge them with complex subqueries
- Introduce window functions (preview of next topic)
- Ask them to optimize slow aggregate queries
- Have them create their own dataset and queries

---

## Additional Resources

- PostgreSQL documentation on aggregate functions
- Practice datasets: sales data, weather data, sports statistics
- Online SQL practice platforms
- `theory.md` for reference

---

## Notes for Instructor

- **Timing is flexible** - adjust based on student comprehension
- **Use visual aids** - draw tables and grouping on board
- **Encourage experimentation** - let students try and fail
- **Real data matters** - relate examples to students' interests
- **Check understanding frequently** - don't move on if confused
- **Celebrate mistakes** - they're learning opportunities

## Follow-Up Lesson Ideas

- Window functions (OVER, PARTITION BY)
- Subqueries and CTEs
- Performance optimization for aggregates
- Advanced grouping (ROLLUP, CUBE, GROUPING SETS)
