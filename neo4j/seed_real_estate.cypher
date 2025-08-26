// Select real_estate database
USE real_estate;

// Constraints and indexes
CREATE CONSTRAINT property_id_unique IF NOT EXISTS
FOR (p:Property)
REQUIRE p.id IS UNIQUE;

CREATE INDEX property_name_if_not_exists IF NOT EXISTS
FOR (p:Property)
ON (p.name);

// Location index (optional for point lookups)
CREATE INDEX property_location_if_not_exists IF NOT EXISTS
FOR (p:Property)
ON (p.location);

// Sample data
// Nodes: Property with point(longitude, latitude) and price
MERGE (:Property {id: "PROP001", name: "Lakeside Villa", price: 450000, location: point({longitude: -122.4194, latitude: 37.7749})});
MERGE (:Property {id: "PROP002", name: "Downtown Loft", price: 650000, location: point({longitude: -73.9857, latitude: 40.7484})});
MERGE (:Property {id: "PROP003", name: "Suburban House", price: 350000, location: point({longitude: -118.2437, latitude: 34.0522})});
MERGE (:Property {id: "PROP004", name: "Beachfront Condo", price: 800000, location: point({longitude: -80.1918, latitude: 25.7617})});
MERGE (:Property {id: "PROP005", name: "Mountain Cabin", price: 275000, location: point({longitude: -105.2705, latitude: 40.0150})});