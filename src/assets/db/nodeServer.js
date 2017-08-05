const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const multer = require('multer');
const multerObj = multer({dest: './static/upload'});
const cookieSession = require('cookie-session');

var app = express();
app.use(multerObj.any());
app.use(bodyParser.urlencoded({extended: false}));
// parse application/json
app.use(bodyParser.json());
app.use(cookieParser());
// 加密session
(function () {
  let keys = [];
  for (let i = 0; i < 1000; i++) {
    keys[i] = 'a_' + Math.random();
  }
  app.use(cookieSession({
    name: 'sess_id',
    keys: keys,
    maxAge: 20 * 60 * 1000
  }));
})();
const router = express.Router();
router.get('/', (req, res) => {
  res.render('./index.html', {});
});
app.use('/user', require('./usermession')());
app.use('/home', require('./article')());
app.use('/editor', require('./editor')());
let staticPath = path.posix.join('/', 'static');
app.use(staticPath, express.static('./static'));
app.listen(8080);

