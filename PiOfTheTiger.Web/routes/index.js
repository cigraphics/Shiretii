
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: global.applicationTile })
};

exports.login = function(req, res){
  res.render('login', { title: global.applicationTile })
};

exports.myhouse = function(req, res){
  res.render('myhouse', { title: global.applicationTile })
};