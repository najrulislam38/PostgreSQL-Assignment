-- Active: 1747539716704@@localhost@5432@conservation_db
-- Create rangers table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
    region VARCHAR(100) NOT NULL
);

-- Create species table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(100),
    discovery_date DATE NOT NULL,
    conservation_status TEXT CHECK (
        conservation_status IN (
            'Endangered',
            'Vulnerable',
            'Historic',
            'Critical'
        )
    )
);

-- Create sightings table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers (ranger_id) NOT NULL,
    species_id INT REFERENCES species (species_id) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    "location" VARCHAR(100) NOT NULL,
    notes TEXT
);

-- insert into rangers table
INSERT INTO
    rangers ("name", region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

-- insert into species table
INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

-- insert into sightings table
INSERT INTO
    sightings (
        ranger_id,
        species_id,
        sighting_time,
        "location",
        notes
    )
VALUES (
        1,
        1,
        '2024-05-10 07:45:00',
        'Peak Ridge',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        '2024-05-12 16:20:00',
        'Bankwood Area',
        'Juvenile seen'
    ),
    (
        3,
        3,
        '2024-05-15 09:10:00',
        'Bamboo Grove East',
        'Feeding observed'
    ),
    (
        2,
        1,
        '2024-05-18 18:30:00',
        'Snowfall Pass',
        NULL
    );

--  Problem 1
INSERT INTO
    rangers ("name", region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2

SELECT COUNT(*) as unique_species_count
FROM (
        SELECT species_id
        FROM species
            JOIN sightings using (species_id)
        GROUP BY
            species_id
    );

-- Problem 3
SELECT * FROM sightings WHERE "location" LIKE ('%Pass');

-- problem 4
SELECT "name", count(*) as total_sightings
FROM rangers
    JOIN sightings USING (ranger_id)
GROUP BY
    ranger_id;

-- Problem 5
SELECT common_name
FROM species
WHERE
    species_id NOT in (
        SELECT species_id
        from sightings
    );

-- Problem 6
SELECT
    common_name,
    sighting_time,
    "name"
FROM sightings
    JOIN species USING (species_id)
    INNER JOIN rangers USING (ranger_id)
ORDER BY sighting_time DESC
LIMIT 2;

-- Problem 7 Not complete -confusion
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    EXTRACT(
        YEAR
        FROM discovery_date
    ) < 1800;

-- Problem 8

SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 12 AND 17  THEN 'Afternoon'
        ELSE 'Evening'
    END
FROM sightings;

-- Problem 9
DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT ranger_id
        FROM sightings
    );