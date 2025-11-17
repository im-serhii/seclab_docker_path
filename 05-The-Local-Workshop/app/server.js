const express = require('express');
const app = express();
const PORT = 8080;

app.get('/', (req, res) => {
  res.send('Hello from inside the container! This is our first custom image.');
});

app.listen(PORT, () => {
  console.log(`Web server is listening on port ${PORT}`);
});
