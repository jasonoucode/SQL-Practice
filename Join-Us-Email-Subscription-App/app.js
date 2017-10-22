// Used to generate fake users
var faker = require('faker');
// DMS for SQL
var mysql = require('mysql');


// open connection to local database
var connection = mysql.createConnection({
   host     :   'localhost',
   user     :   'username',
   database :   'database'
});

// Generate 500 fake database users
var data = [];

for(var i = 0; i < 500; ++i) {
    data.push([
        faker.internet.email(),
        faker.date.past()
    ]);
}

// MySQL and NodeJS insert statement
var q ='INSERT INTO users (email, created_at) VALUES ?';

connection.query(q, [data], function (error, results) {
  if (error) throw error;
  console.log(results);
});

// close connection
connection.end();
