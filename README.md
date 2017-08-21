# 个人博客
****
# 前言

<p>本项目利用了前端技术以及后台nodejs，mysql数据库搭建而成的一个个人博客,由于是使用VUE来做的所以做成了单页面应用，其主要功能有注册登录，主页面预览，图片预览，最近发布文章预览，文章列表，文章详细页，以及编辑文章发布页。其主要功能已经实现，后续还会继续对此项目更新，增加新的功能和页面</p>


项目构建所用到的技术

## 前端技术栈：
*****
 vue2 + vuex + vue-router + 原生JS + webpack + ES6/7 + axios + flex + animatecss + bootstrap
 ****
## 后台技术栈：
***
nodejs + express4 + mysql

## 关于 后台数据接口 的说明
需要把sql文件导入到数据库中才能使用，sql文件在\src\assets\db\learn.sql，数据字典有对数据表的解说说明，建议使用nodejs 6.0以上的版本，因为使用了nodejs作为后台，且使用了大量的es6新特性和语法糖
***
# 项目布局

```
├─build  (webpack配置文件)
├─config (项目打包路径)
├─dist   (上线项目文件，放在服务器即可正常访问)
├─resource (公共资源)
│  └─image (公共图片)
├─src
│  ├─assets (数据库)
│  │  ├─db  (nodejs数据接口文件)
│  │  └─image
│  ├─common
│  │  └─js (公共的方法文件)
│  ├─components (组件群)
│  │  └─base
│  │      ├─404 (404组件)
│  │      ├─article (文章组件)
│  │      ├─detail (文章详情组件)
│  │      ├─editor (文章编辑发布组件)
│  │      ├─home (主页面组件)
│  │      ├─image (图片组件)
│  │      ├─list (文章列表组件)
│  │      ├─login (登录注册组件)
│  │      ├─Reason (人生哲理组件)
│  │      └─wecome (欢迎组件)
│  ├─router (路由)
│  └─store (vuex store管理)
├─static (静态地址)
│  └─upload
└─test
    ├─e2e(自动化测试)
    │  ├─custom-assertions
    │  └─specs
    └─unit
        └─specs

```
## V 0.4.1
修复了因为代码优化带来的文章统计数错误的BUG.
## V 0.4.0
更新了404页面,用纯CSS3制作.

<img src='https://raw.githubusercontent.com/guxiangyuan11/IMAGE/master/images/1/404%E9%A1%B5%E9%9D%A2.png'>

## V 0.3.0
修复登录按钮BUG和优化了体验，增加了防止恶意操作行为，添加了游客模式，可通过登录页面直接进入，游客模式只能浏览博客文章不能发表文章和编辑文章
## V 0.2.1
优化了详情页进入动画和编辑页进入动画，
把nodejs服务器提出到了 src/assets/db/nodeServer 中方便生产模式下应用，不会影响到开发环境照常使用npm run dev就行了
## V 0.2.0
新增了当前文章修改编辑功能

## V 0.1.0
修复一些BUG和做了一些IE的兼容.

# 部分截图：
### 进入页面
<img src='https://raw.githubusercontent.com/guxiangyuan11/IMAGE/master/images/1/%E8%BF%9B%E5%85%A5%E9%A1%B5%E9%9D%A2.jpg'>

###  主页面
<img src='https://raw.githubusercontent.com/guxiangyuan11/IMAGE/master/images/1/%E4%B8%BB%E9%A1%B5%E9%9D%A2.jpg'>

### 文章最近发布浏览
<img src='https://raw.githubusercontent.com/guxiangyuan11/IMAGE/master/images/1/%E5%8D%9A%E5%AE%A2%E6%96%87%E7%AB%A0%E6%9C%80%E8%BF%91%E5%8F%91%E5%B8%83%E9%A1%B5.jpg'>

### 图片页面以及浏览图片

<img src='https://raw.githubusercontent.com/guxiangyuan11/IMAGE/master/images/1/%E5%9B%BE%E7%89%87%E9%A1%B5%E9%9D%A2.jpg'>
<img src='https://raw.githubusercontent.com/guxiangyuan11/IMAGE/master/images/1/%E5%9B%BE%E7%89%87%E9%A2%84%E8%A7%88%E9%A1%B5%E9%9D%A2.jpg'>

### 编辑发布文章页面
<img src='https://raw.githubusercontent.com/guxiangyuan11/IMAGE/master/images/1/%E6%96%87%E7%AB%A0%E5%8F%91%E5%B8%83%E7%BC%96%E8%BE%91%E9%A1%B5%E9%9D%A2.jpg'>

### 文章列表页面
<img src='https://raw.githubusercontent.com/guxiangyuan11/IMAGE/master/images/1/%E6%96%87%E7%AB%A0%E5%88%97%E8%A1%A8.jpg'>

### 文章详情页面
<img src='https://raw.githubusercontent.com/guxiangyuan11/IMAGE/master/images/1/%E6%96%87%E7%AB%A0%E8%AF%A6%E7%BB%86%E9%A1%B5.jpg'>
