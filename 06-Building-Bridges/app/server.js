const express = require('express');
const { Pool } = require('pg');
const app = express();
const PORT = 8080;

// Configuration for the database connection
const pool = new Pool({
  user: 'postgres', // default user
  host: 'my-database', // the name of the database service
  database: 'postgres', // default database
  password: 'mysecretpassword',
  port: 5432,
});

app.get('/', async (req, res) => {
  try {
    const client = await pool.connect();
    // Query the database to get the current time
    const result = await client.query('SELECT NOW()');
    client.release();
    res.send(`Database time is: ${result.rows[0].now}`);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error connecting to the database');
  }
});

app.listen(PORT, () => {
  console.log(`Web server is listening on port ${PORT}`);
});
