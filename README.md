### Marine Rescue Center Database

A relational database design and query project for DST 340 (SQL). The database, `MarineRescueCenter`, models a simulated Pacific Coast marine wildlife rescue and rehabilitation facility.

#### Concept

The rescue center brings in injured or recovering marine wildlife, monitors their health, and houses them in habitat-simulating tanks until they are healthy enough to be released back into the wild. Real Pacific Coast marine species, habitats, and water conditions were used throughout to keep the data realistic.

#### Schema

Five related tables, tied together with primary and foreign keys and full referential integrity:

- HABITATS - natural marine environments: region, salinity level, temperature, depth range
- SPECIES - biological details per species: scientific name, preferred water type, viable temperature range, home habitat
- TANKS - each tank replicates exactly one habitat, with its own size and temperature
- STAFF - rescue center employees, each assigned to one tank
- TANKSPECIES - the many-to-many bridge table between tanks and species, tracking quantity, date added, and health status

Relationships: each species belongs to one habitat, while a habitat can support many species. Each tank simulates exactly one habitat, though multiple tanks can represent the same habitat. Staff are assigned to exactly one tank. Tanks and species connect through the TANKSPECIES bridge table.

See `schema.sql` for the full table definitions and sample data, and `queries.sql` for the analytical queries below.

#### Example queries

Which species can't tolerate warm water (max tolerated temperature of 12 degrees or below)?

```sql
select *
from SPECIES
where MaxTemp <= 12;
```

Which tanks are currently outside the safe temperature range for the species living in them?

```sql
select TANKS.TankName, SPECIES.CommonName, TANKS.Temperature, SPECIES.MinTemp, SPECIES.MaxTemp
from TANKS
join TANKSPECIES on TANKS.TankID = TANKSPECIES.TankID
join SPECIES on TANKSPECIES.SpeciesID = SPECIES.SpeciesID
where TANKS.Temperature < SPECIES.MinTemp
   or TANKS.Temperature > SPECIES.MaxTemp;
```

Which staff members have handled the most fish overall?

```sql
select STAFF.FirstName, STAFF.LastName, STAFF.Role, sum(TANKSPECIES.Quantity) as TotalFishHandled
from STAFF
join TANKS on STAFF.TankID = TANKS.TankID
join TANKSPECIES on TANKS.TankID = TANKSPECIES.TankID
group by STAFF.StaffID, STAFF.FirstName, STAFF.LastName, STAFF.Role
order by TotalFishHandled desc;
```

#### Tech

MySQL 8.4
