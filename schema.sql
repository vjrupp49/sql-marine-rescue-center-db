-- Marine Rescue Center Database
-- Schema + sample data for MarineRescueCenter

CREATE DATABASE IF NOT EXISTS MarineRescueCenter;
USE MarineRescueCenter;

CREATE TABLE HABITATS (
    HabitatID INT,
    HabitatName VARCHAR(100) NOT NULL,
    Region VARCHAR(100) NOT NULL,
    AvgTemp INT NOT NULL,
    DepthRange VARCHAR(50) NOT NULL,
    SalinityLevel VARCHAR(50) NOT NULL,
    PRIMARY KEY (HabitatID)
);

CREATE TABLE SPECIES (
    SpeciesID INT,
    CommonName VARCHAR(100) NOT NULL,
    ScientificName VARCHAR(100) NOT NULL,
    WaterType VARCHAR(50) NOT NULL,
    MinTemp INT NOT NULL,
    MaxTemp INT NOT NULL,
    HabitatID INT NOT NULL,
    PRIMARY KEY (SpeciesID),
    FOREIGN KEY (HabitatID) REFERENCES HABITATS(HabitatID)
);

CREATE TABLE TANKS (
    TankID INT,
    TankName VARCHAR(100) NOT NULL,
    WaterType VARCHAR(50) NOT NULL,
    Temperature INT NOT NULL,
    TankSizeGallons INT NOT NULL,
    HabitatID INT NOT NULL,
    PRIMARY KEY (TankID),
    FOREIGN KEY (HabitatID) REFERENCES HABITATS(HabitatID)
);

CREATE TABLE STAFF (
    StaffID INT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Role VARCHAR(75) NOT NULL,
    HireDate DATE NOT NULL,
    TankID INT NOT NULL,
    PRIMARY KEY (StaffID),
    FOREIGN KEY (TankID) REFERENCES TANKS(TankID)
);

CREATE TABLE TANKSPECIES (
    TankSpeciesID INT,
    TankID INT NOT NULL,
    SpeciesID INT NOT NULL,
    Quantity INT NOT NULL,
    DateAdded DATE NOT NULL,
    Health VARCHAR(50) NOT NULL,
    PRIMARY KEY (TankSpeciesID),
    FOREIGN KEY (TankID) REFERENCES TANKS(TankID),
    FOREIGN KEY (SpeciesID) REFERENCES SPECIES(SpeciesID)
);

-- Sample data

INSERT INTO HABITATS VALUES
(1, 'Kelp Forest', 'California Coast', 12, '5-30m', 'High'),
(2, 'Rocky Intertidal', 'Pacific Northwest', 11, '0-5m', 'Variable'),
(3, 'Pacific Coral Reef', 'Hawaii', 25, '5-40m', 'High'),
(4, 'Open Ocean Pelagic', 'Eastern Pacific', 15, '0-200m', 'High'),
(5, 'Estuary', 'San Francisco Bay', 14, '0-10m', 'Brackish'),
(6, 'Deep Sea Shelf', 'Pacific Continental Shelf', 6, '200-1000m', 'High'),
(7, 'Seagrass Meadow', 'Southern California', 18, '1-10m', 'Moderate'),
(8, 'Cold Upwelling Zone', 'Oregon Coast', 10, '10-100m', 'High');

INSERT INTO SPECIES VALUES
(1, 'Garibaldi', 'Hypsypops rubicundus', 'Saltwater', 14, 20, 1),
(2, 'Rockfish', 'Sebastes spp.', 'Saltwater', 8, 14, 8),
(3, 'Pacific Halibut', 'Hippoglossus stenolepis', 'Saltwater', 6, 12, 6),
(4, 'Clownfish', 'Amphiprion ocellaris', 'Saltwater', 24, 28, 3),
(5, 'Leopard Shark', 'Triakis semifasciata', 'Saltwater', 12, 20, 5),
(6, 'Pacific Herring', 'Clupea pallasii', 'Saltwater', 7, 12, 4),
(7, 'Opaleye', 'Girella nigricans', 'Saltwater', 15, 22, 7),
(8, 'Lingcod', 'Ophiodon elongatus', 'Saltwater', 7, 13, 8);

INSERT INTO TANKS VALUES
(1, 'Kelp Tank A', 'Saltwater', 15, 8000, 1),
(2, 'Intertidal Touch Tank', 'Saltwater', 11, 1500, 2),
(3, 'Reef Exhibit', 'Saltwater', 26, 12000, 3),
(4, 'Pelagic Tank', 'Saltwater', 14, 50000, 4),
(5, 'Estuary Habitat Tank', 'Brackish', 14, 10000, 5),
(6, 'Deep Cold Tank', 'Saltwater', 7, 20000, 6),
(7, 'Seagrass Tank', 'Saltwater', 18, 7000, 7),
(8, 'Upwelling Tank', 'Saltwater', 10, 9000, 8);

INSERT INTO STAFF VALUES
(1, 'Emma', 'Reyes', 'Marine Biologist', '2022-06-12', 1),
(2, 'Liam', 'Chen', 'Aquarist', '2023-03-05', 2),
(3, 'Sophia', 'Martinez', 'Veterinary Tech', '2021-09-18', 3),
(4, 'Noah', 'Anderson', 'Tank Maintenance', '2024-01-10', 4),
(5, 'Ava', 'Singh', 'Aquarist', '2022-11-22', 5),
(6, 'Ethan', 'Garcia', 'Marine Biologist', '2020-07-30', 6),
(7, 'Mia', 'Kim', 'Water Quality Specialist', '2023-08-14', 7),
(8, 'Lucas', 'Brown', 'Aquarist', '2021-04-09', 8);

INSERT INTO TANKSPECIES VALUES
(1, 1, 1, 6, '2026-01-10', 'Healthy'),
(2, 2, 2, 10, '2026-02-12', 'Stable'),
(3, 3, 4, 8, '2026-01-25', 'Healthy'),
(4, 4, 6, 20, '2026-03-01', 'Healthy'),
(5, 5, 5, 3, '2026-02-05', 'Recovering'),
(6, 6, 3, 2, '2026-01-18', 'Critical'),
(7, 7, 7, 12, '2026-02-20', 'Healthy'),
(8, 8, 8, 4, '2026-03-03', 'Stable');
