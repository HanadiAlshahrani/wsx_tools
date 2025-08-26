# Neo4j Multi-Database Seed

This setup creates two Neo4j databases and seeds them with dummy data:

- `bank`: Accounts, Banks, and Transfers with fields: name, id, transfer time, transfer type, amount, bank name
- `realestate`: Property data with fields: long, lat, id, name, price

## Files

- `init/01_create_databases.cypher`: Creates databases and constraints/indexes
- `seed/02_seed_bank.cypher`: Seeds the `bank` database
- `seed/03_seed_realestate.cypher`: Seeds the `realestate` database

## How to Run

You can run these scripts with Neo4j Desktop, Neo4j Aura, or any Neo4j 5.x instance.

### Option A: Neo4j Browser
1. Start your Neo4j 5.x instance and log into Neo4j Browser at `http://localhost:7474`.
2. Run the contents of `init/01_create_databases.cypher`.
3. Switch to `bank` database (`:use bank`) if not already switched, then run `seed/02_seed_bank.cypher`.
4. Switch to `realestate` database (`:use realestate`), then run `seed/03_seed_realestate.cypher`.

### Option B: cypher-shell
If you have `cypher-shell` installed and admin access:

```bash
# Create databases (requires admin)
cypher-shell -u neo4j -p <password> -d system -f init/01_create_databases.cypher

# Seed bank
yes | sed 's/^:use bank;//' seed/02_seed_bank.cypher | cypher-shell -u neo4j -p <password> -d bank

# Seed real estate
yes | sed 's/^:use realestate;//' seed/03_seed_realestate.cypher | cypher-shell -u neo4j -p <password> -d realestate
```

Note: Remove the `:use` lines or execute each file within the correct database context.

## Verify

Run these queries to verify counts:

```cypher
:use bank
MATCH (a:Account) RETURN count(a) AS accounts;
MATCH (t:Transfer) RETURN count(t) AS transfers;
MATCH (b:Bank) RETURN count(b) AS banks;
```

```cypher
:use realestate
MATCH (p:Property) RETURN count(p) AS properties;
```

## Example Queries

```cypher
:use bank
MATCH (s:Account)-[:SENT]->(tr:Transfer)-[:RECEIVED_BY]->(r:Account)
RETURN tr.id, s.name AS sender, r.name AS receiver, tr.transfer_type, tr.amount, tr.transfer_time, tr.bank_name
ORDER BY tr.transfer_time DESC;
```

```cypher
:use realestate
MATCH (p:Property)
WHERE p.price > 300000 AND p.lat IS NOT NULL AND p.long IS NOT NULL
RETURN p.id, p.name, p.price, p.lat, p.long
ORDER BY p.price DESC;
```