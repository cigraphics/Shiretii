
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: global.applicationTile, user:req.session.user })
};

exports.login = function(req, res){
  res.render('login', { title: global.applicationTile, user:req.session.user })
};

exports.myhouse = function(req, res){
  res.render('myhouse', { title: global.applicationTile, user:req.session.user })
};

exports.settings = function(req, res){
  res.render('settings', { title: global.applicationTile, user:req.session.user })
};