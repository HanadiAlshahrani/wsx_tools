// Create databases (requires admin)
CREATE DATABASE bank IF NOT EXISTS;
CREATE DATABASE realestate IF NOT EXISTS;

// Switch to bank database and create constraints and sample schema
:use bank;
CREATE CONSTRAINT bank_account_id_unique IF NOT EXISTS
FOR (a:Account)
REQUIRE a.id IS UNIQUE;

CREATE INDEX account_name_idx IF NOT EXISTS
FOR (a:Account)
ON (a.name);

CREATE CONSTRAINT bank_name_unique IF NOT EXISTS
FOR (b:Bank)
REQUIRE b.name IS UNIQUE;

// Switch to realestate database
:use realestate;
CREATE CONSTRAINT property_id_unique IF NOT EXISTS
FOR (p:Property)
REQUIRE p.id IS UNIQUE;

CREATE INDEX property_name_idx IF NOT EXISTS
FOR (p:Property)
ON (p.name);

CREATE INDEX property_price_idx IF NOT EXISTS
FOR (p:Property)
ON (p.price);

CREATE INDEX property_location_idx IF NOT EXISTS
FOR (p:Property)
ON (p.lat, p.long);