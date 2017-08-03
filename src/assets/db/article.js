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
  router.post('/article/mod', (req, res) => {
    let title = req.body.title;
    let summary = req.body.summary;
    let content = req.body.content;
    let post_time = req.body.post_time;
    let author = req.body.author;
    let up_praise = req.body.up_praise;
    let original_Reprinted = req.body.original_Reprinted;
    let low_praise = req.body.low_praise;
    let overview = req.body.overview;
    if (title && content && post_time && author && author) {
      db.query(`UPDATE article_table SET title='${title}', summary='${summary}', content='${content}', post_time=${post_time}, author='${author}', up_praise=${up_praise}, original_Reprinted=${original_Reprinted}, low_praise=${low_praise}, overview='${overview}' WHERE ID=${req.body.ID}`, (err, data) => {
        if (err) {
          console.log(err);
          res.status(500).send('article更新失败').end();
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
  router.post('/article/banner/mod', (req, res) => {
    let title = req.body.title;
    let description = req.body.description;
    let href = req.body.href;
    let post_time = req.body.post_time;
    let author = req.body.author;
    let year = req.body.year;
    if (title && post_time && author && description) {
      db.query(`UPDATE banner_table SET title='${title}', post_time=${post_time}, author='${author}', href='${href}', description='${description}', year=${year} WHERE ID=${req.body.ID}`, (err, data) => {
        if (err) {
          console.log(err);
          res.status(500).send('banner更新失败').end();
        } else {
          res.json({success: 1});
        }
      });
    } else {
      res.status(404).send('err');
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
