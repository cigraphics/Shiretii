
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , moment = require('moment')
  , mysql = require('mysql')
  , url = require('url')
  , qs = require('qs');

var app = module.exports = express();

// Configuration

app.configure(function ()
{
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');
    app.use(express.bodyParser());
    app.use(express.cookieParser('piOfTheTiger@pass'));
    app.use(express.methodOverride());
    app.use(express.session());
    app.use(app.router);
    
    app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

//mysql database

global.mySqlPool  = mysql.createPool({
  host : 'localhost',
  user : 'root',
  password : '1234%asd',
  database : 'piofthetiger'
});



//global

app.locals.appSettings = { date: new moment().calendar() };

global.applicationTile= "PiOfTheTiger";

// Routes

app.get('/', routes.index);
app.get('/Login', routes.login);
app.get('/MyHouse', checkAuth, routes.myhouse);
app.get('/Settings', checkAuth, routes.settings);


app.listen(process.env.port || 3000);
console.log("Express server listening on port %d in %s mode", (process.env.port || 3000), app.settings.env);


function checkAuth(req, res, next) {
  if (req.session.user && req.session.user.isAuthenticated) {
      next();
  } else {
    res.redirect('/login?returnUrl='+req.path);
  }
}

app.get('/logout', function (req, res) {
  delete req.session.user;
  res.redirect('/');
});

app.post('/login', function (req, res)
{
    global.mySqlPool.getConnection(function (err, connection)
    {
        var userName = req.body.user;
        var password = req.body.password;
        var sql = 'select IdUser from users where Username=' + connection.escape(userName) + ' and password = ' + connection.escape(password);
        connection.query(sql, function (err, rows)
        {
            if (err) throw err;
            if (rows[0])
            {
                req.session.user = { isAuthenticated: true, name: userName, id: rows[0].IdUser };
                var parsedUrl = qs.parse(url.parse(req.url).query);
                var returnUrl = parsedUrl.returnUrl || req.body.returnUrl;
                if (req.body.returnUrl)
                    res.redirect(req.body.returnUrl);
                else
                    res.redirect('/');
            }
            else
            {
                res.redirect('/login?loginfailed=true');
            }
        });
        connection.end();
    });
});

app.post('/saveGeneralSettings', function (req, res)
{
    global.mySqlPool.getConnection(function (err, connection)
    {
        var tolerance = req.body.tolerance;
        var sqlTolerance = 'update appsettings set `Value`=' + connection.escape(tolerance) + ' where `Key`=\'PicturesCompareTolerance\';';
        connection.query(sqlTolerance, function (err, rows)
        {
            if (err) res.redirect('/Settings?erroSaveSettings=true', { error: err });
        });
        connection.end();
    });

    global.mySqlPool.getConnection(function (err, connection)
    {
        var imgPath = req.body.imgPath;
        var sqlimgPath = 'update appsettings set `Value` = ' + connection.escape(imgPath) + ' where `Key` = \'PicturesSavePath\'';
        connection.query(sqlimgPath, function (err, rows)
        {
            if (err) res.redirect('/Settings?erroSaveSettings=true', { error: err });
        });
        connection.end();
    });

    global.mySqlPool.getConnection(function (err, connection)
    {
        var imgSaveInterval = req.body.imgSaveInterval;
        var sqlimgSaveInterval = 'update appsettings set `Value` = ' + connection.escape(imgSaveInterval) + ' where `Key` = \'PicturesSaveInterval\'';
        connection.query(sqlimgSaveInterval, function (err, rows)
        {
            if (err) res.redirect('/Settings?erroSaveSettings=true', { error: err });
        });
        connection.end();
    });
    res.redirect('/Settings');
});