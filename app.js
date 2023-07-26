const http = require('http');

const hostname = '0.0.0.0'; // Listen on all network interfaces

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello, World for ecs deployment!\n');
});

server.listen(() => {
  console.log(`Server running at http://${hostname}/`);
});

