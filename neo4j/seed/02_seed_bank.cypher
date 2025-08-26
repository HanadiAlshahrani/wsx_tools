// Seed data for bank database
:use bank;

// Create banks
UNWIND [
  {name:'First National Bank'},
  {name:'City Capital Bank'},
  {name:'Continental Trust'}
] AS b
MERGE (bank:Bank {name:b.name});

// Create accounts
UNWIND [
  {id:'A-1001', name:'Alice Johnson', bank:'First National Bank'},
  {id:'A-1002', name:'Bob Smith', bank:'City Capital Bank'},
  {id:'A-1003', name:'Charlie Davis', bank:'Continental Trust'},
  {id:'A-1004', name:'Dana Lee', bank:'First National Bank'}
] AS a
MERGE (acct:Account {id:a.id})
  ON CREATE SET acct.name = a.name
MERGE (bank:Bank {name:a.bank})
MERGE (acct)-[:HAS_ACCOUNT_AT]->(bank);

// Create transfers
// Fields: name (sender name), id (transfer id), transfer time, transfer type, amount, bank name
UNWIND [
  {id:'T-2001', sender:'Alice Johnson', receiver:'Bob Smith', transferTime:datetime('2024-10-02T10:15:00Z'), type:'WIRE', amount:1250.50, bank:'First National Bank'},
  {id:'T-2002', sender:'Bob Smith', receiver:'Charlie Davis', transferTime:datetime('2024-10-03T09:30:00Z'), type:'ACH', amount:300.00, bank:'City Capital Bank'},
  {id:'T-2003', sender:'Charlie Davis', receiver:'Dana Lee', transferTime:datetime('2024-10-04T14:20:00Z'), type:'CARD', amount:79.99, bank:'Continental Trust'},
  {id:'T-2004', sender:'Dana Lee', receiver:'Alice Johnson', transferTime:datetime('2024-10-05T18:45:00Z'), type:'WIRE', amount:5000.00, bank:'First National Bank'}
] AS t
MATCH (sender:Account {name:t.sender})
MATCH (receiver:Account {name:t.receiver})
MERGE (b:Bank {name:t.bank})
MERGE (tr:Transfer {id:t.id})
  ON CREATE SET tr.name = t.sender + '->' + t.receiver,
                tr.transfer_time = t.transferTime,
                tr.transfer_type = t.type,
                tr.amount = t.amount,
                tr.bank_name = t.bank
MERGE (sender)-[:SENT]->(tr)
MERGE (tr)-[:RECEIVED_BY]->(receiver)
MERGE (tr)-[:PROCESSED_BY]->(b);