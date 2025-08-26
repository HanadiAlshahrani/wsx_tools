// Select bank database
USE bank;

// Constraints and indexes
CREATE CONSTRAINT bank_account_id_unique IF NOT EXISTS
FOR (a:Account)
REQUIRE a.id IS UNIQUE;

CREATE INDEX account_name_if_not_exists IF NOT EXISTS
FOR (a:Account)
ON (a.name);

CREATE INDEX bank_name_if_not_exists IF NOT EXISTS
FOR (b:Bank)
ON (b.name);

// Sample data
// Banks
MERGE (b1:Bank {name: "First National Bank"});
MERGE (b2:Bank {name: "City Credit Union"});
MERGE (b3:Bank {name: "Riverbank Trust"});

// Accounts
MERGE (a1:Account {id: "ACC1001", name: "Alice Johnson"});
MERGE (a2:Account {id: "ACC1002", name: "Bob Smith"});
MERGE (a3:Account {id: "ACC1003", name: "Carol Lee"});
MERGE (a4:Account {id: "ACC1004", name: "David Chen"});

// Link accounts to banks
MERGE (a1)-[:HAS_ACCOUNT_AT]->(b1);
MERGE (a2)-[:HAS_ACCOUNT_AT]->(b2);
MERGE (a3)-[:HAS_ACCOUNT_AT]->(b1);
MERGE (a4)-[:HAS_ACCOUNT_AT]->(b3);

// Transfers
// Properties: transfer_time (datetime), transfer_type (string), amount (float)
MERGE (a1)-[:TRANSFERED_TO {
  transfer_time: datetime("2024-06-01T09:15:00Z"),
  transfer_type: "wire",
  amount: 1250.50,
  bank_name: "First National Bank"
}]->(a2);

MERGE (a2)-[:TRANSFERED_TO {
  transfer_time: datetime("2024-06-02T14:30:00Z"),
  transfer_type: "ach",
  amount: 300.00,
  bank_name: "City Credit Union"
}]->(a3);

MERGE (a3)-[:TRANSFERED_TO {
  transfer_time: datetime("2024-06-03T08:00:00Z"),
  transfer_type: "card",
  amount: 45.75,
  bank_name: "First National Bank"
}]->(a4);

MERGE (a4)-[:TRANSFERED_TO {
  transfer_time: datetime("2024-06-04T20:45:00Z"),
  transfer_type: "wire",
  amount: 5000.00,
  bank_name: "Riverbank Trust"
}]->(a1);