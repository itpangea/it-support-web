const express = require('express');
const mysql = require('mysql');

const app = express();
const port = 3000;

// Configuración de la conexión a la base de datos
const dbConfig = {
  host: 'mysql',
  user: 'root',
  password: 'password',
  database: 'it_support_web'
};

// Creación de la conexión a la base de datos
const connection = mysql.createConnection(dbConfig);

// Creación de la tabla de clientes si no existe
connection.query(
  `CREATE TABLE IF NOT EXISTS clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    zone VARCHAR(255) NOT NULL,
    postal_code VARCHAR(255) NOT NULL,
    case_number VARCHAR(255) NOT NULL,
    issue TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )`,
  (error) => {
    if (error) {
      console.error('Error creating clients table:', error);
    } else {
      console.log('Clients table created or already exists');
    }
  }
);

// Configuración de las rutas
app.use(express.json());

app.post('/api/support', (req, res) => {
    const { name, email, phone, zone, postalCode, issue } = req.body;
  
    // Generar un ID o número de caso único
    const caseNumber = generateCaseNumber();
  
    // Inserción de los datos en la tabla de clientes
    connection.query(
      'INSERT INTO clients (name, email, phone, zone, postal_code, issue, case_number) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [name, email, phone, zone, postalCode, issue, caseNumber],
      (error) => {
        if (error) {
          console.error('Error inserting data into clients table:', error);
          res.sendStatus(500);
        } else {
          console.log('Data inserted into clients table');
          res.sendStatus(200);
        }
      }
    );
  });  

// Inicio del servidor
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});