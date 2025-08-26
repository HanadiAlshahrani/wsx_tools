// Seed data for real estate database
:use realestate;

UNWIND [
  {id:'P-3001', name:'Maple Residence', price:350000, lat:37.7749, long:-122.4194},
  {id:'P-3002', name:'Lakeside Villa', price:825000, lat:34.0522, long:-118.2437},
  {id:'P-3003', name:'Sunset Apartments', price:210000, lat:40.7128, long:-74.0060},
  {id:'P-3004', name:'Oakwood Cottage', price:450000, lat:47.6062, long:-122.3321}
] AS p
MERGE (prop:Property {id:p.id})
  ON CREATE SET prop.name = p.name,
                prop.price = p.price,
                prop.lat = p.lat,
                prop.long = p.long;