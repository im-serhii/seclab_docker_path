const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();
app.use(cors());
const PORT = 3001;

const pool = new Pool({
  user: process.env.POSTGRES_USER,
  host: process.env.DB_HOST,
  database: process.env.POSTGRES_DB,
  password: process.env.POSTGRES_PASSWORD,
  port: 5432,
});

app.get('/api/data', async (req, res) => {
  try {
    const client = await pool.connect();
    const result = await client.query('SELECT * FROM messages');
    client.release();
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: 'Failed to fetch data from the database' });
  }
});

app.listen(PORT, () => {
  console.log(`Backend server is listening on port ${PORT}`);
});
