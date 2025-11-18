-- AGGREGATE FUNCTIONS AND GROUP BY EXAMPLES
-- From easiest to hardest
-- 
-- AGGREGATE FUNCTIONS: Functions that perform calculations on multiple rows and return a single result
-- Common aggregates: COUNT(), SUM(), AVG(), MIN(), MAX()
-- 
-- GROUP BY: Groups rows with the same values into summary rows
-- HAVING: Filters groups (like WHERE but for groups)

-- ============================================
-- BASIC AGGREGATE FUNCTIONS (No GROUP BY)
-- ============================================

-- 1. COUNT: How many planets are in our solar system?
-- COUNT(*) counts all rows in the table
-- Result: 8 planets
SELECT COUNT(*) AS total_planets
FROM solar_system.planets;

-- 2. SUM: Total number of moons in the solar system
-- SUM() adds up all values in a column
-- Result: 285 total moons (Saturn has 146, Jupiter has 95, etc.)
SELECT SUM(number_of_moons) AS total_moons
FROM solar_system.planets;

-- 3. AVG: Average distance from the sun
-- AVG() calculates the mean (average) of all values
-- Useful for finding the "typical" value in a dataset
SELECT AVG(distance_from_sun_million_km) AS avg_distance_million_km
FROM solar_system.planets;

-- 4. MIN and MAX: Smallest and largest planet by diameter
-- MIN() finds the minimum value, MAX() finds the maximum value
-- Mercury is smallest (4,879 km), Jupiter is largest (139,820 km)
SELECT 
    MIN(diameter_km) AS smallest_diameter,
    MAX(diameter_km) AS largest_diameter
FROM solar_system.planets;

-- 5. Multiple aggregates together
-- You can use multiple aggregate functions in one query
-- Each aggregate operates independently on the entire dataset
SELECT 
    COUNT(*) AS total_planets,
    AVG(diameter_km) AS avg_diameter,
    SUM(number_of_moons) AS total_moons,
    MAX(mass_earth_units) AS heaviest_planet_mass
FROM solar_system.planets;

-- ============================================
-- GROUP BY - Single Column
-- ============================================
-- GROUP BY divides rows into groups based on column values
-- Then aggregate functions are calculated for EACH group separately

-- 6. Count planets by type
-- Groups planets into categories and counts each category
-- Result: 4 terrestrial, 2 gas giants, 2 ice giants
SELECT 
    planet_type,
    COUNT(*) AS planet_count
FROM solar_system.planets
GROUP BY planet_type;

-- 7. Average diameter by planet type
-- Shows size statistics for each planet category
-- Gas giants are much larger than terrestrial planets
SELECT 
    planet_type,
    AVG(diameter_km) AS avg_diameter,
    MIN(diameter_km) AS min_diameter,
    MAX(diameter_km) AS max_diameter
FROM solar_system.planets
GROUP BY planet_type;

-- 8. Total moons by planet type
-- Demonstrates that larger planets have more moons
-- Gas and ice giants have most of the solar system's moons
SELECT 
    planet_type,
    SUM(number_of_moons) AS total_moons,
    AVG(number_of_moons) AS avg_moons_per_planet
FROM solar_system.planets
GROUP BY planet_type;

-- 9. Group by boolean: Planets with and without rings
-- Boolean columns can also be used for grouping
-- Only 4 planets have rings (all are gas/ice giants)
SELECT 
    has_rings,
    COUNT(*) AS planet_count,
    AVG(number_of_moons) AS avg_moons
FROM solar_system.planets
GROUP BY has_rings;

-- ============================================
-- GROUP BY with ORDER BY
-- ============================================
-- ORDER BY sorts the grouped results
-- You can order by aggregate functions or grouped columns

-- 10. Planet types ordered by total mass
-- Shows which planet category contains the most mass
-- Gas giants dominate with Jupiter alone being 317.8 Earth masses
SELECT 
    planet_type,
    COUNT(*) AS planet_count,
    SUM(mass_earth_units) AS total_mass,
    AVG(mass_earth_units) AS avg_mass
FROM solar_system.planets
GROUP BY planet_type
ORDER BY total_mass DESC;

-- 11. Find which planet type has the most moons on average
-- ORDER BY can use aggregate functions calculated in SELECT
-- Gas giants win with an average of 120.5 moons per planet
SELECT 
    planet_type,
    AVG(number_of_moons) AS avg_moons,
    MAX(number_of_moons) AS max_moons
FROM solar_system.planets
GROUP BY planet_type
ORDER BY avg_moons DESC;

-- ============================================
-- HAVING Clause (Filtering Groups)
-- ============================================
-- HAVING filters groups AFTER aggregation (WHERE filters rows BEFORE grouping)
-- Use HAVING when you need to filter based on aggregate function results
-- Think: WHERE = filter rows, HAVING = filter groups

-- 12. Planet types with more than 2 planets
-- HAVING filters out groups that don't meet the condition
-- Only 'terrestrial' type has more than 2 planets (it has 4)
SELECT 
    planet_type,
    COUNT(*) AS planet_count
FROM solar_system.planets
GROUP BY planet_type
HAVING COUNT(*) > 2;

-- 13. Planet types with average diameter greater than 10000 km
-- Filters to show only large planet categories
-- Gas giants and ice giants pass this filter, terrestrial planets don't
SELECT 
    planet_type,
    AVG(diameter_km) AS avg_diameter,
    COUNT(*) AS planet_count
FROM solar_system.planets
GROUP BY planet_type
HAVING AVG(diameter_km) > 10000;

-- 14. Planet types with total moons greater than 50
-- Shows which planet categories have many moons collectively
-- Gas giants have 241 total moons (Saturn 146 + Jupiter 95)
SELECT 
    planet_type,
    SUM(number_of_moons) AS total_moons,
    COUNT(*) AS planet_count
FROM solar_system.planets
GROUP BY planet_type
HAVING SUM(number_of_moons) > 50;

-- ============================================
-- WHERE + GROUP BY + HAVING
-- ============================================
-- Execution order: WHERE (filter rows) → GROUP BY (create groups) → HAVING (filter groups)
-- WHERE filters individual rows BEFORE grouping
-- HAVING filters groups AFTER aggregation

-- 15. For planets with rings, show types with average mass > 10 Earth units
-- WHERE filters to only ringed planets first (4 planets)
-- Then groups them and HAVING filters to massive planet types
-- Only gas giants pass both filters
SELECT 
    planet_type,
    COUNT(*) AS planet_count,
    AVG(mass_earth_units) AS avg_mass,
    SUM(number_of_moons) AS total_moons
FROM solar_system.planets
WHERE has_rings = TRUE
GROUP BY planet_type
HAVING AVG(mass_earth_units) > 10;

-- 16. For discovered planets (not NULL discovery_year), group by type
-- WHERE filters to only planets discovered with telescopes (Uranus and Neptune)
-- Shows when each planet type was first and last discovered
SELECT 
    planet_type,
    COUNT(*) AS discovered_planets,
    MIN(discovery_year) AS first_discovered,
    MAX(discovery_year) AS last_discovered
FROM solar_system.planets
WHERE discovery_year IS NOT NULL
GROUP BY planet_type;

-- 17. Planets farther than 200 million km, grouped by type, with avg mass > 1
-- WHERE: Only outer planets (beyond Mars)
-- GROUP BY: Group by planet type
-- HAVING: Only groups where average mass exceeds Earth's mass
-- Result shows the massive outer planets
SELECT 
    planet_type,
    COUNT(*) AS planet_count,
    AVG(distance_from_sun_million_km) AS avg_distance,
    AVG(mass_earth_units) AS avg_mass
FROM solar_system.planets
WHERE distance_from_sun_million_km > 200
GROUP BY planet_type
HAVING AVG(mass_earth_units) > 1
ORDER BY avg_distance;

-- ============================================
-- ADVANCED: Multiple Grouping Columns
-- ============================================
-- You can group by multiple columns to create more specific categories
-- Each unique combination of values creates a separate group

-- 18. Group by planet type and ring status
-- Creates separate groups for each combination: (terrestrial, no rings), (gas_giant, rings), etc.
-- Shows that all terrestrial planets lack rings, while all gas/ice giants have them
SELECT 
    planet_type,
    has_rings,
    COUNT(*) AS planet_count,
    AVG(number_of_moons) AS avg_moons
FROM solar_system.planets
GROUP BY planet_type, has_rings
ORDER BY planet_type, has_rings;

-- ============================================
-- ADVANCED: Aggregate with CASE
-- ============================================
-- CASE expressions can create custom categories for grouping
-- This is powerful for creating meaningful classifications from numeric data

-- 19. Categorize planets by distance and count them
-- CASE creates three regions: Inner (< 200M km), Middle (200-1000M km), Outer (> 1000M km)
-- Shows that outer planets are larger and have more moons
-- Inner: Mercury, Venus, Earth, Mars
-- Middle: Jupiter
-- Outer: Saturn, Uranus, Neptune
SELECT 
    CASE 
        WHEN distance_from_sun_million_km < 200 THEN 'Inner'
        WHEN distance_from_sun_million_km < 1000 THEN 'Middle'
        ELSE 'Outer'
    END AS solar_region,
    COUNT(*) AS planet_count,
    AVG(diameter_km) AS avg_diameter,
    SUM(number_of_moons) AS total_moons
FROM solar_system.planets
GROUP BY solar_region
ORDER BY MIN(distance_from_sun_million_km);

-- 20. Complex: Categorize by size and show statistics
-- Creates size categories and lists which planets belong to each
-- STRING_AGG concatenates planet names into a comma-separated list
-- HAVING filters out categories with only 1 planet
-- Small: Mercury, Venus, Mars (< 10,000 km)
-- Large: Jupiter, Saturn, Uranus, Neptune (> 50,000 km)
SELECT 
    CASE 
        WHEN diameter_km < 10000 THEN 'Small'
        WHEN diameter_km < 50000 THEN 'Medium'
        ELSE 'Large'
    END AS size_category,
    COUNT(*) AS planet_count,
    AVG(mass_earth_units) AS avg_mass,
    AVG(number_of_moons) AS avg_moons,
    STRING_AGG(name, ', ' ORDER BY name) AS planet_names
FROM solar_system.planets
GROUP BY size_category
HAVING COUNT(*) >= 2
ORDER BY AVG(mass_earth_units) DESC;

-- ============================================
-- EXPERT LEVEL: Complex Aggregations
-- ============================================
-- These queries combine multiple advanced concepts:
-- subqueries, percentage calculations, and comparative analysis

-- 21. Percentage of total moons by planet type
-- Uses a subquery to calculate the total moons in the entire solar system
-- Then calculates what percentage each planet type contributes
-- Gas giants have 84.6% of all moons (241 out of 285)
-- This shows how to calculate proportions within groups
SELECT 
    planet_type,
    SUM(number_of_moons) AS type_moons,
    ROUND(100.0 * SUM(number_of_moons) / (SELECT SUM(number_of_moons) FROM solar_system.planets), 2) AS percentage_of_total
FROM solar_system.planets
GROUP BY planet_type
ORDER BY type_moons DESC;

-- 22. Compare each planet type to overall averages
-- Calculates group averages AND overall averages in the same query
-- Subqueries in SELECT calculate the overall average for comparison
-- Shows that gas giants are much larger and heavier than the solar system average
-- Useful pattern for benchmarking groups against the overall population
SELECT 
    planet_type,
    COUNT(*) AS planet_count,
    ROUND(AVG(diameter_km), 2) AS avg_diameter,
    ROUND((SELECT AVG(diameter_km) FROM solar_system.planets), 2) AS overall_avg_diameter,
    ROUND(AVG(mass_earth_units), 4) AS avg_mass,
    ROUND((SELECT AVG(mass_earth_units) FROM solar_system.planets), 4) AS overall_avg_mass
FROM solar_system.planets
GROUP BY planet_type
ORDER BY avg_mass DESC;
