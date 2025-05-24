-- Active: 1747539716704@@localhost@5432@conservation_db
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
    region VARCHAR(100) NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(100),
    discovery_date DATE NOT NULL,
    conservation_status TEXT CHECK (
        conservation_status IN ('Endangered', 'Vulnerable')
    )
);

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
        1,
        2,
        '2024-05-18 18:30:00',
        'Snowfall Pass',
        NULL
    );

DROP TABLE sightings;

SELECT * FROM rangers;

SELECT * FROM species;

SELECT * FROM sightings;