// express framework
var express = require('express');
// fake data library
var faker = require('faker');
// sql dms
var mysql = require('mysql');
// parsing post data
var bodyparser = require("body-parser");



// variable for using the module
var app = express();
app.set("view engine", "ejs");
app.use(bodyparser.urlencoded({extended: true}));
app.use(express.static(__dirname + '/public'));

// connection
var connection = mysql.createConnection({
   host     :   'localhost',
   user     :   'root',
   database :   'join_us'
});

// var data = [];

// for(var i = 0; i < 500; ++i) {
//     data.push([
//         faker.internet.email(),
//         faker.date.past()
//     ]);
// }

// var q ='INSERT INTO users (email, created_at) VALUES ?';

// connection.query(q, [data], function (error, results) {
//   if (error) throw error;
//   console.log(results);
// });

// connection.end();

// get routing '/'
app.get("/", function(req, res) {
	var q = "SELECT COUNT (*) AS count FROM users";
	connection.query(q, function(error, results) {
		if (error) throw error;
		var count = results[0].count;
		//res.send("We have " + count + " users in our db.");
		res.render("home", {count: count});
	});
});

// post routing '/register'
app.post("/register", function(req, res) {
	// bodyparser to get the post data body
	var person = {
		email: req.body.email
	};

	// send the data to the sql db using mysql
	connection.query('INSERT INTO users SET ?', person, function(error, result) {
		if (error) throw error;
		console.log(result);
		// redirect back to home
		res.redirect('/');
	});
});

// on $ node app.js
app.listen(8080, function () {
	// response to our terminal
	console.log('App listening on port 8080!');
});

