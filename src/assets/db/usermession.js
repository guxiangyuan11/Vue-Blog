/* eslint-disable handle-callback-err,eqeqeq */
const experss = require('express');
const mysql = require('mysql');
const pathLib = require('path');
const fs = require('fs');
const db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '123456',
  database: 'learn'
});
const MD5 = require('../../common/js/MD5');

module.exports = function () {
  const router = experss.Router();
  // 拿到用户信息
  router.get('/usermessage', (req, res) => {
    if (req.query.name) {
      db.query(`SELECT avatar FROM user_table WHERE username='${req.query.name}'`, (err, data) => {
        if (err) {
          console.error(err);
          res.status(500).send('dataBase').end();
        } else {
          res.send(data);
        }
      });
    } else {
      res.status(404).send('请求错误').end();
    }
  });
  // 接收注册信息
  router.post('/sign', (req, res) => {
    let username = req.body.username;
    let password = MD5.md5(req.body.password);
    console.log(req.files[0]);
    var oldName = req.files[0].path;
    // 拼接传过来的文件的路径
    var newName = oldName + pathLib.parse(req.files[0].originalname).ext;
    // 修改文件名字 eg：1c75c87ba8cc1171714792d4af3209c6.jpg
    var newFilename = req.files[0].filename + pathLib.parse(req.files[0].originalname).ext;
    fs.rename(oldName, newName, (err) => {
      if (err) {
        console.log(err);
       res.status(500).send('dataBase error').end();
      } else {
        // 先查找数据库中有没有相同的用户名
        db.query(`SELECT * FROM user_table WHERE username='${username}'`, (err, data) => {
          if (err) {
            console.error(err);
            res.status(500).json({error: 0}).end();
          } else {
            // 判断有无用户
            if (data.length === 0) {
              // 这里表没有这个用户名可以注册
              db.query(`INSERT INTO user_table (username,password,avatar) VALUES('${username}','${password}','${newFilename}')`, (err, data) => {
                if (err) {
                  console.error(err);
                  res.status(500).json({error: 0}).end();
                } else {
                  res.json({success: 1});
                }
              });
            } else {
              // 表示有这个用户名不能注册
              console.error('有这个用户名不能注册');
              res.status(400).json({error: 1}).end();
            }
          }
        });
      }
    });
  });
  // 接收登录信息
  router.post('/login', (req, res) => {
    let username = req.body.username;
    let password = req.body.password;
    db.query(`SELECT * FROM user_table WHERE username='${username}'`, (err, data) => {
      if (err) {
        console.error(err);
        res.status(500).json({error: 0}).end();
      } else {
        if (data.length === 0) {
          // 表示无法找到相应的
          console.error('无法找到相应的用户名');
          res.status(400).json({error: 1}).end();
        } else {
          if (data[0].password == MD5.md5(password)) {
            // 如果密码正确就设置一个session
            // req.session['user_id'] = data[0].ID; 由于前端拿不到session所以用cookie
            // 设置cookie，参数：键值，路径，最大存在时间,打开签名
            res.cookie('user', 'ok', {maxAge: 1000 * 60 * 60 * 10});
            res.json({ok: true}).end();
          } else {
            console.error('密码错误');
            res.status(404).json({error: 2}).end();
          }
        }
      }
    });
  });
  return router;
};

