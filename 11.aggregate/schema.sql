-- Create schema for solar system
-- A schema is like a folder that organizes related tables together
CREATE SCHEMA IF NOT EXISTS solar_system;

-- Set search path to use the schema
-- This means we don't need to write "solar_system.planets" every time
SET search_path TO solar_system;

-- Create planets table
-- This table stores information about planets in our solar system
CREATE TABLE planets (
    -- Primary key: unique identifier for each planet (auto-incremented)
    planet_id SERIAL PRIMARY KEY,
    
    -- Planet name (e.g., Earth, Mars, Jupiter)
    name VARCHAR(50) NOT NULL,
    
    -- Type of planet: 'terrestrial' (rocky), 'gas_giant', or 'ice_giant'
    -- Useful for GROUP BY operations to compare planet categories
    planet_type VARCHAR(20) NOT NULL,
    
    -- Distance from the Sun in millions of kilometers
    -- Mercury is closest (~58), Neptune is farthest (~4495)
    distance_from_sun_million_km NUMERIC(10, 2) NOT NULL,
    
    -- Planet diameter in kilometers (equatorial)
    -- Jupiter is largest (139,820 km), Mercury is smallest (4,879 km)
    diameter_km INTEGER NOT NULL,
    
    -- Mass relative to Earth (Earth = 1.0)
    -- Jupiter is 317.8 times heavier than Earth
    mass_earth_units NUMERIC(10, 4) NOT NULL,
    
    -- Number of natural satellites (moons) orbiting the planet
    -- Saturn has the most with 146 known moons
    number_of_moons INTEGER DEFAULT 0,
    
    -- Whether the planet has a ring system
    -- Only gas and ice giants have prominent rings
    has_rings BOOLEAN DEFAULT FALSE,
    
    -- Year the planet was discovered (NULL for planets known since ancient times)
    -- Mercury through Saturn were known to ancient civilizations
    discovery_year INTEGER
);
