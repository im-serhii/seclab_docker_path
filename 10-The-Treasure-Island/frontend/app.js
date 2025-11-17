document.getElementById('fetch-button').addEventListener('click', () => {
  const dataContainer = document.getElementById('data-container');
  dataContainer.textContent = 'Loading...';

  // This request goes to the backend service.
  // In a real setup, a reverse proxy would route this, but for simplicity
  // we are calling it directly on the port it's exposed on.
  fetch('http://localhost:3001/api/data')
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      dataContainer.textContent = `Message from DB: "${data[0].message}"`;
    })
    .catch(error => {
      dataContainer.textContent = `Error: ${error.message}. Is the backend running?`;
      console.error('Fetch error:', error);
    });
});
