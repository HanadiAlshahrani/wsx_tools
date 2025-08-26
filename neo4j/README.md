# Neo4j: Bank and Real Estate Databases

This folder contains Cypher scripts to create two Neo4j databases and seed them with dummy data.

- `create_databases.cypher`: Creates `bank` and `real_estate` databases in the `system` database
- `seed_bank.cypher`: Defines schema and dummy data for the `bank` database
- `seed_real_estate.cypher`: Defines schema and dummy data for the `real_estate` database

## Requirements
- Neo4j 5.x or newer
- `cypher-shell` available in PATH

## Usage
Replace `<NEO4J_USER>` and `<NEO4J_PASSWORD>` as needed. If running locally with default auth, user is typically `neo4j`.

```bash
# 1) Create databases (run against system database)
cypher-shell -u <NEO4J_USER> -p <NEO4J_PASSWORD> -d system -f /workspace/neo4j/create_databases.cypher

# 2) Seed the bank database
cypher-shell -u <NEO4J_USER> -p <NEO4J_PASSWORD> -d bank -f /workspace/neo4j/seed_bank.cypher

# 3) Seed the real estate database
cypher-shell -u <NEO4J_USER> -p <NEO4J_PASSWORD> -d real_estate -f /workspace/neo4j/seed_real_estate.cypher
```

## Sample Queries
```cypher
// Bank: list transfers with amounts
MATCH (from:Account)-[t:TRANSFERED_TO]->(to:Account)
RETURN from.name AS from, to.name AS to, t.transfer_type AS type, t.amount AS amount, t.transfer_time AS at
ORDER BY t.transfer_time;
```

```cypher
// Real estate: properties within 10km of a point
WITH point({longitude: -122.4194, latitude: 37.7749}) AS center
MATCH (p:Property)
WHERE distance(p.location, center) < 10000
RETURN p.name, p.price
ORDER BY p.price DESC;
```