/* eslint-disable camelcase,no-unused-vars */
const experss = require('express');
const mysql = require('mysql');
const db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '123456',
  database: 'learn'
});

module.exports = function () {
      var count = 12;
  const router = experss.Router();
  // 添加文章
   router.post('/article/add', (req, res) => {
     var title = req.body.title;
     var summary = req.body.summary;
     var content = req.body.content;
     var post_time = req.body.post_time;
     var author = req.body.author;
     var up_praise = req.body.up_praise;
     var original_Reprinted = req.body.original_Reprinted;
     var low_praise = req.body.low_praise;
     var overview = req.body.overview;
     if (title && content && post_time && author && author) {
       count++;
       db.query(`INSERT INTO article_table (title,summary,content,post_time, author, up_praise, original_Reprinted,low_praise,overview, ID) VALUE ('${title}', '${summary}', '${content}', ${post_time}, '${author}', ${up_praise}, ${original_Reprinted}, ${low_praise}, '${overview}', ${count})`, (err, data) => {
         if (err) {
           console.log(err);
           res.status(500).send('err').end();
         } else {
           res.json({success: 1});
         }
       });
     }
   });
  // 添加banner页
   router.post('/article/banner', (req, res) => {
     var title = req.body.title;
     var description = req.body.description;
     var href = req.body.href;
     var post_time = req.body.post_time;
     var author = req.body.author;
     var year = req.body.year;
     if (title && post_time && author && description) {
       db.query(`INSERT INTO banner_table (title,description,href,post_time,author,year,ID) VALUE ('${title}', '${description}', '${href}', ${post_time}, '${author}', ${year}, ${count})`, (err, data) => {
         if (err) {
           console.log(err);
           res.status(500).send('err').end();
         } else {
           res.json({success: 1});
         }
       });
     }
  });
  // 返回最大ID
  router.get('/article/bannerID', (req, res) => {
    db.query('SELECT *,MAX(ID) FROM banner_table', (err, data) => {
      if (err) {
        console.log(err);
        res.status(500).send('err').end();
      } else {
        res.send(data);
      }
    });
  });
  // 详细页面
  router.get('/article/detail', (req, res) => {
    db.query(`SELECT * FROM article_table WHERE ID=${req.query.id}`, (err, data) => {
      if (err) {
        console.log(err);
        res.status(500).send('err').end();
      } else {
        res.send(data);
      }
    });
  });
  router.get('/article', (req, res) => {
    // 判断是请求详细页面还是请求最近发布页面
    if (req.query.id) {
      db.query(`SELECT * FROM banner_table WHERE year=${req.query.id} ORDER BY post_time DESC`, (err, data) => {
        if (err) {
          console.error(err);
          res.status(500).send('dataBase error').end();
        } else {
          res.send(data);
        }
      });
    } else {
      // 请求最近发布页面
      db.query('SELECT *  FROM banner_table ORDER BY post_time DESC', (err, data) => {
        if (err) {
          console.error(err);
          res.status(500).json({erron: 5}).end();
        } else {
          res.send(data);
        };
      });
    }
  });
  return router;
};
