
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: global.applicationTile, user:req.session.user })
};

exports.login = function(req, res){
  
  res.render('login', { title: global.applicationTile, user:req.session.user })
};

exports.myhouse = function (req, res)
{
    console.log(global.savedPictures);
    res.render('myhouse', { title: global.applicationTile, user: req.session.user, pictures: global.savedPictures, picturesPath: global.PicturesPath })
};

exports.settings = function (req, res)
{    
    res.render('settings', { title: global.applicationTile, user: req.session.user, picSavedPath: global.picturesSavedPath,
        picSaveInterval: global.picuresInterval, picTolerance: picturesTolerance});
};