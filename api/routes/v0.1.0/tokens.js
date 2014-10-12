var express = require('express');
var router = express.Router();

/* GET token create. */
router.get('/create', function(req, res) {
	var db = req.db;
	var model = req.model
	
	var fluffy = new model.TokenModel({ 
		app: 'miyou' ,
		version: 'v0.1.0',
		os: 'ios',
		token: 'B1504D99F0C0DB8048709EC58BACD4A1054CB331C57627A042E72CE1DFC6873F'
	});
	
	fluffy.save(function (err, fluffy) {
	  if (err) return console.error(err);

		 res.json({
			 message: 'hooray! welcome to our api!',
		 	 data:fluffy,
			 status:{
				 code: 0,
				 msg : 'success'
			 }
		 });
	});
});

router.get('/', function(req, res) {
	var db = req.db;
	var model = req.model
	
	var fluffy = new model.TokenModel({ 
		app: 'miyou' ,
		version: 'v0.1.0',
		os: 'ios',
		token: 'B1504D99F0C0DB8048709EC58BACD4A1054CB331C57627A042E72CE1DFC6873F'
	});

	// Tank.find({ size: 'small' }).where('createdDate').gt(oneYearAgo).exec(callback);
	model.TokenModel.find().exec(function(err,docs){
		if (err) return console.error(err);
		
		res.json({
		 data:docs,
		 status:{
			 code: 0,
			 msg : 'success'
		 }
		});	
	});  
});

module.exports = router;
