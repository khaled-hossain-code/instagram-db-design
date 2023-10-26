beforeAll(() => {
  // randomly generate a role
  // connect to PG as usual
  // create a new role
  `CREATE ROLE ${rolename} with LOGIN PASSWORD '${rolename}';`;

  // create a schema with the same name
  `CREATE SCHEMA ${rolename} AUTHORIZATION ${rolename}`;
  // disconnect from PG
  // run our migration in new schema
  // connect to PG as newly created role
});

beforeEach(() => {
  `DELETE FROM users`;
});

afterAll(() => {
  // disconnect from PG
  // Reconnect as our Root user
  // Delete the role and schema we created
  `DROP SCHEMA ${rolename} CASCADE;``DROP ROLE ${rolename};`;
  // Disconnect
});
