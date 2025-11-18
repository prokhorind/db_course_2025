-- Insert solar system planets data
-- This dataset includes all 8 planets with real astronomical data
SET search_path TO solar_system;

INSERT INTO planets (name, planet_type, distance_from_sun_million_km, diameter_km, mass_earth_units, number_of_moons, has_rings, discovery_year) VALUES
-- TERRESTRIAL PLANETS (Rocky planets in the inner solar system)
('Mercury', 'terrestrial', 57.9, 4879, 0.0553, 0, FALSE, NULL),      -- Smallest, closest to Sun, no moons
('Venus', 'terrestrial', 108.2, 12104, 0.8150, 0, FALSE, NULL),     -- Hottest planet, similar size to Earth
('Earth', 'terrestrial', 149.6, 12742, 1.0000, 1, FALSE, NULL),     -- Our home, reference point for mass (1.0)
('Mars', 'terrestrial', 227.9, 6779, 0.1074, 2, FALSE, NULL),       -- Red planet, has 2 small moons

-- GAS GIANTS (Massive planets made mostly of hydrogen and helium)
('Jupiter', 'gas_giant', 778.6, 139820, 317.8000, 95, TRUE, NULL), -- Largest planet, most massive, Great Red Spot
('Saturn', 'gas_giant', 1433.5, 116460, 95.1600, 146, TRUE, NULL), -- Famous rings, most moons

-- ICE GIANTS (Large planets with icy compositions)
('Uranus', 'ice_giant', 2872.5, 50724, 14.5360, 27, TRUE, 1781),  -- Rotates on its side, discovered with telescope
('Neptune', 'ice_giant', 4495.1, 49244, 17.1470, 14, TRUE, 1846); -- Farthest planet, strongest winds
