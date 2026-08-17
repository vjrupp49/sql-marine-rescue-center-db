-- Marine Rescue Center Database - analytical queries

-- Species that can't tolerate warm water (max tolerated temp <= 12)
SELECT *
FROM SPECIES
WHERE MaxTemp <= 12;

-- Every tank, the species living in it, and how many of each
SELECT TANKS.TankName, SPECIES.CommonName, TANKSPECIES.Quantity
FROM TANKS
JOIN TANKSPECIES ON TANKS.TankID = TANKSPECIES.TankID
JOIN SPECIES ON TANKSPECIES.SpeciesID = SPECIES.SpeciesID;

-- Total fish population per tank
SELECT TANKS.TankName, SUM(TANKSPECIES.Quantity) AS TotalFish
FROM TANKS
JOIN TANKSPECIES ON TANKS.TankID = TANKSPECIES.TankID
GROUP BY TANKS.TankName;

-- Tanks ranked by size
SELECT TankName, TankSizeGallons
FROM TANKS
ORDER BY TankSizeGallons DESC;

-- Species with "Rock" in the name
SELECT CommonName
FROM SPECIES
WHERE CommonName LIKE '%Rock%';

-- Tanks running between 10 and 15 degrees
SELECT TankName, Temperature
FROM TANKS
WHERE Temperature BETWEEN 10 AND 15;

-- Tanks currently outside the safe temperature range for their species
SELECT TANKS.TankName, SPECIES.CommonName, TANKS.Temperature, SPECIES.MinTemp, SPECIES.MaxTemp
FROM TANKS
JOIN TANKSPECIES ON TANKS.TankID = TANKSPECIES.TankID
JOIN SPECIES ON TANKSPECIES.SpeciesID = SPECIES.SpeciesID
WHERE TANKS.Temperature < SPECIES.MinTemp
   OR TANKS.Temperature > SPECIES.MaxTemp;

-- Staff ranked by total fish handled across their assigned tank
SELECT STAFF.FirstName, STAFF.LastName, STAFF.Role, SUM(TANKSPECIES.Quantity) AS TotalFishHandled
FROM STAFF
JOIN TANKS ON STAFF.TankID = TANKS.TankID
JOIN TANKSPECIES ON TANKS.TankID = TANKSPECIES.TankID
GROUP BY STAFF.StaffID, STAFF.FirstName, STAFF.LastName, STAFF.Role
ORDER BY TotalFishHandled DESC;
