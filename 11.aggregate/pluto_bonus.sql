-- ============================================
-- BONUS: The Pluto Problem 🪐
-- ============================================
-- A fun exercise about the most controversial planet (or is it?)
-- 
-- In 2006, Pluto was reclassified from a planet to a "dwarf planet"
-- This caused quite a stir in the astronomical community!
-- Let's explore what happens when we include Pluto in our dataset...

-- First, let's add Pluto to our table
-- (Don't worry, we'll remove it at the end)
INSERT INTO solar_system.planets (name, planet_type, distance_from_sun_million_km, diameter_km, mass_earth_units, number_of_moons, has_rings, discovery_year) 
VALUES ('Pluto', 'dwarf_planet', 5906.4, 2376, 0.0022, 5, FALSE, 1930);

-- ============================================
-- QUERY 1: The Identity Crisis
-- ============================================
-- How many planets do we have now?
-- Spoiler: It depends on who you ask! 😅
SELECT COUNT(*) AS planet_count,
       'Wait, I thought there were 8 planets?' AS comment
FROM solar_system.planets;

-- ============================================
-- QUERY 2: Pluto's Lonely Category
-- ============================================
-- Count planets by type - notice Pluto is all alone
-- Poor Pluto, the only dwarf planet in our dataset
SELECT 
    planet_type,
    COUNT(*) AS planet_count,
    CASE 
        WHEN planet_type = 'dwarf_planet' THEN '😢 Forever alone'
        ELSE '👥 Has friends'
    END AS social_status
FROM solar_system.planets
GROUP BY planet_type
ORDER BY planet_count DESC;

-- ============================================
-- QUERY 3: Size Matters (Or Does It?)
-- ============================================
-- Compare Pluto to other planets
-- Pluto is smaller than Earth's moon!
SELECT 
    name,
    diameter_km,
    CASE 
        WHEN diameter_km < 3000 THEN '🐭 Tiny (smaller than our Moon!)'
        WHEN diameter_km < 10000 THEN '🏀 Small'
        WHEN diameter_km < 50000 THEN '⚽ Medium'
        ELSE '🏐 Large'
    END AS size_category
FROM solar_system.planets
ORDER BY diameter_km;

-- ============================================
-- QUERY 4: The Exclusion Principle
-- ============================================
-- What if we only count "real" planets?
-- Using HAVING to exclude dwarf planets from our summary
SELECT 
    planet_type,
    COUNT(*) AS planet_count,
    AVG(diameter_km) AS avg_diameter,
    SUM(number_of_moons) AS total_moons
FROM solar_system.planets
GROUP BY planet_type
HAVING planet_type != 'dwarf_planet'  -- Sorry Pluto! 💔
ORDER BY avg_diameter DESC;

-- ============================================
-- QUERY 5: Pluto's Revenge
-- ============================================
-- Show ONLY dwarf planets (Pluto gets the spotlight!)
-- In reality, there are 5 recognized dwarf planets:
-- Pluto, Eris, Haumea, Makemake, and Ceres
SELECT 
    name,
    diameter_km,
    number_of_moons,
    discovery_year,
    '🌟 Still special to us!' AS status
FROM solar_system.planets
WHERE planet_type = 'dwarf_planet';

-- ============================================
-- QUERY 6: The Distance Problem
-- ============================================
-- Pluto is REALLY far away
-- It's almost 40 times farther from the Sun than Earth!
SELECT 
    name,
    distance_from_sun_million_km,
    ROUND(distance_from_sun_million_km / 149.6, 1) AS distance_in_AU,
    CASE 
        WHEN distance_from_sun_million_km > 5000 THEN '📡 Need a really long phone cable'
        WHEN distance_from_sun_million_km > 1000 THEN '🚀 Pretty far'
        ELSE '🏠 Relatively close'
    END AS communication_difficulty
FROM solar_system.planets
ORDER BY distance_from_sun_million_km DESC;

-- ============================================
-- QUERY 7: The Mass Debate
-- ============================================
-- Pluto is lighter than 7 of Jupiter's moons!
-- Compare masses to see why size was a factor in the reclassification
SELECT 
    planet_type,
    COUNT(*) AS planet_count,
    ROUND(AVG(mass_earth_units), 4) AS avg_mass,
    ROUND(MIN(mass_earth_units), 4) AS lightest,
    ROUND(MAX(mass_earth_units), 4) AS heaviest,
    CASE 
        WHEN AVG(mass_earth_units) < 0.01 THEN '🪶 Featherweight division'
        WHEN AVG(mass_earth_units) < 1 THEN '🥊 Lightweight division'
        WHEN AVG(mass_earth_units) < 100 THEN '💪 Heavyweight division'
        ELSE '🏋️ Super heavyweight division'
    END AS weight_class
FROM solar_system.planets
GROUP BY planet_type
ORDER BY avg_mass DESC;

-- ============================================
-- QUERY 8: Historical Perspective
-- ============================================
-- Pluto was discovered in 1930 and demoted in 2006
-- It was a planet for 76 years!
SELECT 
    name,
    discovery_year,
    2006 - discovery_year AS years_as_planet,
    CASE 
        WHEN discovery_year IS NULL THEN '👴 Known since ancient times'
        WHEN name = 'Pluto' THEN '⏰ 76 years of planetary status (1930-2006)'
        ELSE '🌍 Still a planet!'
    END AS history
FROM solar_system.planets
WHERE discovery_year IS NOT NULL
ORDER BY discovery_year;

-- ============================================
-- QUERY 9: The Percentage Problem
-- ============================================
-- What percentage of "planets" in our table are dwarf planets?
-- This shows how one outlier can affect statistics
SELECT 
    planet_type,
    COUNT(*) AS count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM solar_system.planets), 2) AS percentage,
    CASE 
        WHEN planet_type = 'dwarf_planet' THEN '🎯 The 11% that caused all the drama'
        ELSE '✅ Undisputed planets'
    END AS controversy_level
FROM solar_system.planets
GROUP BY planet_type
ORDER BY count DESC;

-- ============================================
-- QUERY 10: The Final Verdict
-- ============================================
-- Let's be diplomatic and show ALL celestial bodies
-- Because in our hearts, Pluto is still special ❤️
SELECT 
    CASE 
        WHEN planet_type = 'dwarf_planet' THEN 'Dwarf Planet (but we still love you!)'
        ELSE INITCAP(REPLACE(planet_type, '_', ' '))
    END AS category,
    STRING_AGG(name, ', ' ORDER BY distance_from_sun_million_km) AS members,
    COUNT(*) AS count
FROM solar_system.planets
GROUP BY planet_type
ORDER BY 
    CASE planet_type
        WHEN 'terrestrial' THEN 1
        WHEN 'gas_giant' THEN 2
        WHEN 'ice_giant' THEN 3
        WHEN 'dwarf_planet' THEN 4
    END;

-- ============================================
-- CLEANUP: Restore the Solar System
-- ============================================
-- Remove Pluto to restore the official 8-planet system
-- (But we'll always remember you, Pluto! 🥺)
DELETE FROM solar_system.planets WHERE planet_type = 'dwarf_planet';

-- Verify we're back to 8 planets
SELECT COUNT(*) AS planet_count,
       'Back to the official count!' AS status
FROM solar_system.planets;

-- ============================================
-- 🎓 TEACHING MOMENTS
-- ============================================
-- This exercise demonstrates:
-- 1. How outliers affect aggregate statistics
-- 2. Using CASE for custom categorization
-- 3. String aggregation with STRING_AGG
-- 4. Filtering with WHERE vs HAVING
-- 5. Calculating percentages with subqueries
-- 6. The importance of data classification
-- 7. That science evolves (and so do our databases!)
--
-- 💡 Discussion Questions:
-- - How do outliers affect AVG() calculations?
-- - Why might we want to exclude certain categories from analysis?
-- - What happens to our GROUP BY results when we add a new category?
-- - How can we make our queries flexible for changing definitions?
--
-- 🌟 Fun Fact: 
-- The debate over Pluto's status teaches us that even in databases,
-- classification matters! Just like in SQL, where choosing the right
-- GROUP BY categories affects your entire analysis.
--
-- #NeverForgetPluto #DataClassificationMatters #SQLHumor
