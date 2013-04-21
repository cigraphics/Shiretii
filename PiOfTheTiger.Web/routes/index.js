
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

exports.settings = function (req, res)
{
    var picturesSavedPath = "";
    var picturesTolerance = "";
    var picuresInterval = "";

    global.mySqlPool.getConnection(function (err, connection)
    {
        var sqlPicturesSavePath = "select `Value` from appsettings where ID = 6";
        connection.query(sqlPicturesSavePath, function (err, rows)
        {
            if (err) res.redirect('/Settings?erroReadSettings=true', { error: err });
            picturesSavedPath = rows[0].Value;
            console.log(rows[0].Value);
        });
        connection.end();
    });
    console.log(picturesSavedPath);
    global.mySqlPool.getConnection(function (err, connection)
    {
        var sqlPicturesSaveInterval = "select `Value` from appsettings where ID = 7";
        connection.query(sqlPicturesSaveInterval, function (err, rows)
        {
            if (err) res.redirect('/Settings?erroReadSettings=true', { error: err });
            picuresInterval = rows[0].Value;
            console.log(rows[0].Value);
        });
        connection.end();
    });
    console.log(picuresInterval);
    global.mySqlPool.getConnection(function (err, connection)
    {
        var sqlPicturesTolerance = "select `Value` from appsettings where ID = 8";
        connection.query(sqlPicturesTolerance, function (err, rows)
        {
            if (err) res.redirect('/Settings?erroReadSettings=true', { error: err });
            picturesTolerance = rows[0].Value;
            console.log(rows[0].Value);
        });
        connection.end();
    });
    console.log(picturesTolerance);
    res.render('settings', { title: global.applicationTile, user: req.session.user,
        PicturesSavedPath: picturesSavedPath, PicturesSaveInterval: picuresInterval, PicturesTolerance: picturesTolerance
    });
};