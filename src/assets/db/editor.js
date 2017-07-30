/* eslint-disable handle-callback-err,eqeqeq,no-unused-vars */
const experss = require('express');
const mysql = require('mysql');
const db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '123456',
  database: 'learn'
});
const MD5 = require('../../common/js/MD5');

module.exports = function () {
  let router = experss.Router();
  // 向临时保存表，索要内容
  router.get('/extra', (req, res) => {
    db.query('SELECT * FROM extra_table WHERE act=1', (err, data) => {
       if (err) {
         console.error(err);
         res.status(500).send('dataBase error').end();
       } else {
         if (data.length == 0) {
           // 说明没有数据，向前台传递NO
           res.json({success: 0}).end();
         } else {
           res.send(data).end();
         }
       }
    });
  });
  // 删除临时存储的编辑内容
  router.get('/delete', (req, res) => {
    db.query('SELECT * FROM extra_table WHERE act=1', (err, data) => {
      if (err) {
        console.error(err);
        res.status(500).send('dataBase').end();
      } else {
        if (data.length === 0) {
          res.json({success: 1}).end();
        } else {
          db.query('DELETE FROM extra_table WHERE act=1', (err, data) => {
            if (err) {
              console.error(err);
              res.status(500).send('dataBase error').end();
            } else {
              res.json({success: 1}).end();
            }
          });
        }
      }
    });
  });
  // 向后台请求保存编辑器内容
  router.post('/', (req, res) => {
     db.query('SELECT * FROM extra_table WHERE act=1', (err, data) => {
       if (err) {
         console.error(err);
         res.status(500).send('dataBase').end();
       } else {
         // 表示没有数据
        if (data.length === 0) {
          db.query(`INSERT INTO extra_table (title,summary,content,overview,act) VALUE('${req.body.title}', '${req.body.summar}','${req.body.content}', '${req.body.overview}', 1)`, (err, data) => {
            if (err) {
              console.log('失败');
              console.error(err);
              res.status(500).send('dataBase').end();
            } else {
              console.log('保存成功');
              res.json({success: 'ok'}).end();
            }
          });
        } else {
          // 如果有的话就更新
          db.query(`UPDATE extra_table SET title='${req.body.title}', summary='${req.body.summar}', content='${req.body.content}', overview='${req.body.overview}'`, (err, data) => {
            if (err) {
              console.error(err);
              console.log('更新失败');
              res.status(500).send('dataBase').end();
            } else {
              console.log('更新成功');
              res.json({success: 'ok'}).end();
            }
          });
        }
       }
     });
  });
  return router;
};
