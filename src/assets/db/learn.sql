/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50703
Source Host           : localhost:3306
Source Database       : learn

Target Server Type    : MYSQL
Target Server Version : 50703
File Encoding         : 65001

Date: 2017-07-30 11:49:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article_table
-- ----------------------------
DROP TABLE IF EXISTS `article_table`;
CREATE TABLE `article_table` (
  `ID` int(10) unsigned NOT NULL,
  `title` varchar(100) NOT NULL COMMENT '文章题目',
  `summary` varchar(500) NOT NULL COMMENT '摘要',
  `content` text NOT NULL COMMENT '内容',
  `post_time` int(11) NOT NULL COMMENT '发布时间（按秒）',
  `author` varchar(32) NOT NULL COMMENT '发布者',
  `up_praise` int(11) NOT NULL DEFAULT '0' COMMENT '点赞数',
  `original_Reprinted` int(11) NOT NULL COMMENT '原创（1）OR转载（0）',
  `low_praise` int(11) NOT NULL DEFAULT '0' COMMENT '踩数',
  `overview` varchar(255) DEFAULT NULL COMMENT '作者简介',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='这是专门存储文章的表';

-- ----------------------------
-- Records of article_table
-- ----------------------------
INSERT INTO `article_table` VALUES ('4', '对于用JS无法清除Cookie的解决方法', '这个也是cookie的一个基础知识，关于cookie 设置域（domain），过期时间（expires），路径（path），后也要按照相同的方法来删除cookie', '<p>在使用js对cookie进行删除的时候，发现无论怎么做都删除不了，网上查到的方法也是删除不了。</p><p>以下是我使用的删除代码：</p><p>全部删除</p><pre><code>delAllCookie: function () {\n  var exdate = new Date();\n  exdate.setTime(exdate.getTime() - 1); // 设置时间\n  var data = document.cookie;\n  var dataArray = data.split(\'; \');\n  for (var i = 0; i &lt; dataArray.length; i++) {\n    var varName = dataArray[i].split(\'=\');\n    document.cookie = varName[0] + \"=\'\'; expires=\" + exdate.toGMTString()\n  }\n }</code></pre><p>指定删除：</p><pre><code>delCookie: function (name) {\n  var exdate = new Date();\n    exdate.setTime(exdate.getTime() - 1); // 设置时间\n  document.cookie = name + \"=\'\'; expires=\" + exdate.toGMTString()\n }</code></pre><p>以上的方法，均失效，无法删除cookie，在我一筹莫展的时候，找到了这篇文章 &nbsp;<a href=\"http://php.js.cn/blog/delete-cookie/\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">无法删除Cookie的烦恼。。</a></p><p>大意就是指cookie不仅仅有名字和值两个属性，还有域（domain），过期时间（expires），路径（path）等属性。 其中，不同的域、不同的路径下可以存在同样名字的cookie，如果想删除cookie必须使用相同的域和路径，就是你是怎么设置的cookie就怎么删除。</p><p>一般我们自己使用的方法是直接用相同的名字，把其时间设置成以前的时间，来达到覆盖删除的效果，所以忽略了域和路径，当然我们在设置cookie时没有设置域和路径时，会默认为当前域和根目录，比如我在www.baidu.com设置了一个cookie没设置域和路径，他的默认域为www.baidu.com路径为 “ / ” &nbsp;,所以删除也要按其设置的来。</p><p>这是我设置cookie的代码，由于我是在nodejs中设置的，可能和JS中设置不一样，但效果都一样</p><pre><code>res.cookie(\'user\', \'ok\', {maxAge: 1000 * 60 * 60 * 10});</code></pre><p>所以得对最开始的删除代码进行更改：</p><pre><code>document.cookie = varName[0] + \"=\'\'; expires=\" + exdate.toGMTString() + \'; path=/\';</code></pre><pre><code>document.cookie = name + \"=\'\'; expires=\" + exdate.toGMTString() + \'; path=/\';</code></pre><p><font color=\"#c24f4a\">注意：</font></p><p><font color=\"#c24f4a\">如果在设置中给cookie设置域的话，浏览器存的时候会自动在前面加. ，例如设置成www.baidu.com会变成.www.baidu.com 前面多了个点这个要注意，删的时候也要加上这个点。</font></p>', '1501384144', 'guxiangyuan', '0', '1', '0', '');
INSERT INTO `article_table` VALUES ('6', '单页应用SEO浅谈', '单页应用（Single Page Application）越来越受web开发者欢迎，单页应用的体验可以模拟原生应用，一次开发，多端兼容。单页应用并不是一个全新发明的技术，而是随着互联网的发展，满足用户体验的一种综合技术。', '<h2>SEO</h2><p>一直以来，搜索引擎优化（SEO）是开发者容易忽略的部分。SEO是针对搜索（Google、百度、雅虎搜索等）在技术细节上的优化，例如<strong>语义</strong>、搜索关键词与内容<strong>相关性<strong>、</strong>收录量</strong>、<strong>搜索排名</strong>等。SEO也是同行、市场竞争常用的的营销手段。Google、百度的搜索结果是重要的用户入口，腾讯云（www.qcloud.com）有30%左右的流量来自搜索引擎。因此SEO在品牌、营销、用户量的纬度是非常重要的基础能力。</p><p><!--StartFragment--><!--EndFragment--></p><p>那么单页应用与传统直出页面在SEO方面有哪些不同之处呢？</p><p><h1>单页应用的优点\n</h1>\n<br>更好的用户体验，让用户在web感受natvie的速度和流畅；\n<br>经典MVC开发模式，前后端各负其责。\n<br>一套Server API，多端使用（web、移动APP等）\n<br>重前端，业务逻辑全部在本地操作，数据都需要通过AJAX同步、提交；</p><p><h1>对搜索引擎不友好\n</h1>\n<br>单页应用实际是把视图（View）渲染从Server交给浏览器，Server只提供JSON格式数据，视图和内容都是通过本地JavaScript来组织和渲染。而搜索搜索引擎抓取的内容，需要有完整的HTML和内容，单页应用架构的站点，并不能很好的支持搜索。\n<br>\n<br>如果站点在用户体验和搜索友好权衡时，如果我们做到更好的体验，也做到友好的搜索支持，既是一箭双雕。\n<br>\n<br><h1>URL中的哈希（#号）\n</h1>\n<br>单页应用只有一个页面，视图的变化通常是通过路由（route）来驱动，首先，我们先来谈一谈单页应用的URL中的#号，很多采用单元结构网站的URL都出现了这个符号。\n<br>\n<br>#号在浏览器的URL中是一个锚点，在当前页改变#号的参数，页面会跳转到锚点所在的位置，通过JavaScript我们可以获取到#号后的参数：</p><pre><code>location.hash // 获取URL hash\nlocation.hash = \"#list\" //改变URL h</code></pre><p>改变#号后的参数，页面并不会重载，于是大多数的单页架构网站，都在URL中采用#号来作为当前视图的URL地址，例如：</p><pre><code>example.com/#index  //首页视图\nexample.com/#list   //列表页视图\nexample.com/#list/1   //id为1的列表信息的视图</code></pre><p>Google提出（AJAX 抓取：网站站长和开发人员指南1）：\n<br>\n<br>因为复杂的单页架构页面，对Google来说抓取比较困难，于是给开发者制定一个规范：\n<br>\n<br>网站提交sitemap给Google；\n<br>Google发现URL里有#!符号，例如example.com/#!/detail/1，于是Google开始抓取example.com/?_escaped_fragment_=/detail/1；\n<br>_escaped_fragment_这个参数是Google指定的命名，如果开发者希望把网站内容提交给Google，就必须通过这个参数生成静态页面。</p><p>判断爬虫\n<br>\n<br>当Google访问119.28.4.22/#!/detail/1 时，会自动转化成http://119.28.4.22/?_escaped_fragment_=/detail/1，以Nginx为例：\n<br>\n<br></p><pre><code>if ($args ~ _escaped_fragment_) {\n   rewrite ^ /api;\n}</code></pre><p>/api为后台服务的接口，已nodejs为例，代理设置如下：</p><pre><code>upstream nodejs {\n    server 127.0.0.1:3000;\n}\n \nlocation /api {\n    proxy_set_header X-Request-URI   $request_uri;\n    proxy_set_header X-Real-IP       $remote_addr;\n    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n    proxy_set_header Host            $host;\n    proxy_set_header Port            $server_port;\n    proxy_pass http://nodejs;\n    proxy_redirect off;\n}</code></pre><p>如此，我们便将Google的访问重写到/api这个接口，然后在Server的/api处理请求把静态内容输出即可。</p><p><h1>sitemap\n</h1>\n<br>Gogole的这个规范，必须有sitemap支持，因为有可能单页架构的站点，索引页面也是JavaScript渲染的。提交sitemap时，不用关注_escaped_fragment_这个参数名，只提交带哈希符号的URL即可，例如：</p><pre><code>http://119.28.4.22/#!/detail/1 \nweekly \n0.5</code></pre><p><br></p><p><h1>结语\n</h1>\n<br>技术潮流的步伐很快，单页应用，URL哈希处理也没渲染的方式实际上已经流行了很久，在国外很多用户数据较好的情况下，开发者会选择HTML5 History API的pushstate特性开发，在URL中抛弃#!。但是IE6、7等低端浏览器用户情况较多的网站，#能够很好的兼容。关于采用HTML5 History API来架构单页应用的方案，也欢迎讨论。</p>', '1501384889', 'guxiangyuan', '0', '0', '0', '');
INSERT INTO `article_table` VALUES ('8', 'javascript模块化之CommonJS、AMD、CMD、UMD、ES6', '随着网站逐渐变成”互联网应用程序”，嵌入网页的JavaScript代码越来越庞大，越来越复杂。网页越来越像桌面程序，需要一个团队分工协作、进度管理、单元测试等等……开发者不得不使用软件工程的方法，管理网页的业务逻辑。javascript模块化编程，已经成为一个迫切的需求。理想情况下，开发者只需要实现核心的业务逻辑，其他都可以加载别人已经写好的模块。', '<p><strong>这是一篇关于<a href=\"http://lib.csdn.net/base/javascript\" title=\"JavaScript知识库\" target=\"_blank\">js</a>模块化编程的总结记录</strong></p><p>随着网站逐渐变成”互联网应用程序”，嵌入网页的<a href=\"http://lib.csdn.net/base/javascript\" title=\"JavaScript知识库\" target=\"_blank\">JavaScript</a>代码越来越庞大，越来越复杂。</p><p>网页越来越像桌面程序，需要一个团队分工协作、进度管理、单元<a href=\"http://lib.csdn.net/base/softwaretest\" title=\"软件测试知识库\" target=\"_blank\">测试</a>等等……开发者不得不使用软件工程的方法，管理网页的业务逻辑。</p><p><a href=\"http://lib.csdn.net/base/javascript\" title=\"JavaScript知识库\" target=\"_blank\">javascript</a>模块化编程，已经成为一个迫切的需求。理想情况下，开发者只需要实现核心的业务逻辑，其他都可以加载别人已经写好的模块。</p><p>Javascript社区做了很多努力，在现有的运行环境中，实现”模块”的效果。</p><h2 id=\"commonjs\"><a name=\"t0\" target=\"_blank\"></a>CommonJS</h2><p>这里的CommonJS规范指的是CommonJS Modules/1.0规范。</p><p><!--StartFragment--><!--EndFragment--></p><p>CommonJS是一个更偏向于服务器端的规范。NodeJS采用了这个规范。CommonJS的一个模块就是一个脚本文件。require命令第一次加载该脚本时就会执行整个脚本，然后在内存中生成一个对象。</p><pre><code>{\n  id: \'...\',\n  exports: { ... },\n  loaded: true,\n  ...\n}</code></pre><p>id是模块名，exports是该模块导出的接口，loaded表示模块是否加载完毕。此外还有很多属性，这里省略了。\n<br>\n<br>以后需要用到这个模块时，就会到exports属性上取值。即使再次执行require命令，也不会再次执行该模块，而是到缓存中取值。</p><pre><code>// math.js\nexports.add = function(a, b) {\n  return a + b;\n}</code></pre><pre><code>var math = require(\'math\');\nmath.add(2, 3); // 5</code></pre><p>由于CommonJS是同步加载模块，这对于服务器端不是一个问题，因为所有的模块都放在本地硬盘。等待模块时间就是硬盘读取文件时间，很小。但是，对于浏览器而言，它需要从服务器加载模块，涉及到网速，代理等原因，一旦等待时间过长，浏览器处于”假死”状态。\n<br>\n<br>所以在浏览器端，不适合于CommonJS规范。所以在浏览器端又出现了一个规范—-AMD。\n<br>\n<br><h1>AMD\n</h1>\n<br>CommonJS解决了模块化的问题，但这种同步加载方式并不适合于浏览器端。\n<br>\n<br>AMD是”Asynchronous Module Definition”的缩写，即”异步模块定义”。它采用异步方式加载模块，模块的加载不影响它后面语句的运行。 \n<br>这里异步指的是不堵塞浏览器其他任务（dom构建，css渲染等），而加载内部是同步的（加载完模块后立即执行回调）。\n<br>\n<br>AMD也采用require命令加载模块，但是不同于CommonJS，它要求两个参数：</p><pre><code>require([module], callback);</code></pre><p>第一个参数[module]，是一个数组，里面的成员是要加载的模块，callback是加载完成后的回调函数。如果将上述的代码改成AMD方式：</p><pre><code>require([\'math\'], function(math) {\n  math.add(2, 3);\n})</code></pre><p>其中，回调函数中参数对应数组中的成员（模块）。\n<br>\n<br>requireJS加载模块，采用的是AMD规范。也就是说，模块必须按照AMD规定的方式来写。\n<br>\n<br>具体来说，就是模块书写必须使用特定的define()函数来定义。如果一个模块不依赖其他模块，那么可以直接写在define()函数之中。</p><pre><code>define(id?, dependencies?, factory);</code></pre><p>id：模块的名字，如果没有提供该参数，模块的名字应该默认为模块加载器请求的指定脚本的名字；\n<br>\n<br>dependencies：模块的依赖，已被模块定义的模块标识的数组字面量。依赖参数是可选的，如果忽略此参数，它应该默认为 [\"require\", \"exports\", \"module\"]。然而，如果工厂方法的长度属性小于3，加载器会选择以函数的长度属性指定的参数个数调用工厂方法。\n<br>\n<br>factory：模块的工厂函数，模块初始化要执行的函数或对象。如果为函数，它应该只被执行一次。如果是对象，此对象应该为模块的输出值。\n<br>\n<br>假定现在有一个math.js文件，定义了一个math模块。那么，math.js书写方式如下：\n<br>\n</p><pre><code>// math.js\ndefine(function() {\n  var add = function(x, y) {\n    return x + y;\n  }\n\n  return  {\n    add: add\n  }\n})</code></pre><p>加载方法如下：</p><pre><code>// main.js\nrequire([\'math\'], function(math) {\n  alert(math.add(1, 1));\n})</code></pre><p>如果math模块还依赖其他模块，写法如下：</p><pre><code>// math.js\ndefine([\'dependenceModule\'], function(dependenceModule) {\n  // ...\n})</code></pre><p>当require()函数加载math模块的时候，就会先加载dependenceModule模块。当有多个依赖时，就将所有的依赖都写在define()函数第一个参数数组中，所以说AMD是依赖前置的。这不同于CMD规范，它是依赖就近的。\n<br>\n<br><h1>CMD\n</h1>\n<br>CMD推崇依赖就近，延迟执行。可以把你的依赖写进代码的任意一行，如下：</p><pre><code>define(factory)</code></pre><p>factory为函数时，表示是模块的构造方法。执行该构造方法，可以得到模块向外提供的接口。factory 方法在执行时，默认会传入三个参数：require、exports 和 module.</p><pre><code>// CMD\ndefine(function(require, exports, module) {\n  var a = require(\'./a\');\n  a.doSomething();\n  var b = require(\'./b\');\n  b.doSomething();\n})</code></pre><p>如果使用AMD写法，如下：</p><pre><code>// AMD\ndefine([\'a\', \'b\'], function(a, b) {\n  a.doSomething();\n  b.doSomething();\n})</code></pre><p>这个规范实际上是为了Seajs的推广然后搞出来的。那么看看SeaJS是怎么回事儿吧，基本就是知道这个规范了。\n<br>\n<br>同样Seajs也是预加载依赖js跟AMD的规范在预加载这一点上是相同的，明显不同的地方是调用，和声明依赖的地方。AMD和CMD都是用difine和require，但是CMD标准倾向于在使用过程中提出依赖，就是不管代码写到哪突然发现需要依赖另一个模块，那就在当前代码用require引入就可以了，规范会帮你搞定预加载，你随便写就可以了。但是AMD标准让你必须提前在头部依赖参数部分写好（没有写好？ 倒回去写好咯）。这就是最明显的区别。\n<br>\n<br>sea.js通过sea.use()来加载模块。</p><pre><code>seajs.use(id, callback?)</code></pre><p><h1>UMD\n</h1>\n<br>由于CommonJS是服务器端的规范，跟AMD、CMD两个标准实际不冲突。\n<br>\n<br>当我们写一个文件需要兼容不同的加载规范的时候怎么办呢，看看下面的代码。</p><pre><code>(function (root, factory) {\n\n    if (typeof define === \'function\' &amp;&amp; define.amd) {\n\n        // AMD\n\n        define([\'jquery\', \'underscore\'], factory);\n\n    } else if (typeof exports === \'object\') {\n\n        // Node, CommonJS之类的\n\n        module.exports = factory(require(\'jquery\'), require(\'underscore\'));\n\n    } else {\n\n        // 浏览器全局变量(root 即 window)\n\n        root.returnExports = factory(root.jQuery, root._);\n    }\n}(this, function ($, _) {\n\n    // 方法\n\n    function a(){}; // 私有方法，因为它没被返回 (见下面)\n\n    function b(){}; // 公共方法，因为被返回了\n\n    function c(){}; // 公共方法，因为被返回了\n\n    // 暴露公共方法\n    return {\n        b: b,\n        c: c\n    }\n}));</code></pre><p>这个代码可以兼容各种加载规范了。</p><p><h1>ES6\n</h1>\n<br>es6通过import、export实现模块的输入输出。其中import命令用于输入其他模块提供的功能，export命令用于规定模块的对外接口。\n<br>\n<br>export\n<br>\n<br>一个模块就是一个独立的文件。该文件内部的所有变量，外部无法获取。如果希望外部文件能够读取该模块的变量，就需要在这个模块内使用export关键字导出变量。如：</p><pre><code>// profile.js\nexport var a = 1;\nexport var b = 2;\nexport var c = 3;</code></pre><p>下面的写法是等价的，这种方式更加清晰（在底部一眼能看出导出了哪些变量）：</p><pre><code>var a = 1;\nvar b = 2;\nvar c = 3;\nexport {a, b, c}</code></pre><p>export命令除了输出变量，还可以导出函数或类。\n<br>\n<br>导出函数</p><pre><code>export function foo(){}\nfunction foo(){}\nfunction bar(){}\nexport {foo, bar as bar2}</code></pre><p>其中上面的as表示给导出的变量重命名。\n<br>\n<br>要注意的是，export导出的变量只能位于文件的顶层，如果处于块级作用域内，会报错。如：</p><pre><code>function foo() {\n  export \'bar\'; // SyntaxError\n}</code></pre><p>导出类</p><pre><code>export default class {} // 关于default下面会说</code></pre><p>export语句输出的值是动态绑定，绑定其所在的模块。</p><pre><code>// foo.js\nexport var foo = \'foo\';\n\nsetTimeout(function() {\n  foo = \'foo2\';\n}, 500);\n\n// main.js\nimport * as m from \'./foo\';\n\nconsole.log(m.foo); // foo\nsetTimeout(() =&gt; console.log(m.foo), 500); // foo2</code></pre><p><h1>import\n</h1>\n<br>import命令可以导入其他模块通过export导出的部分。</p><pre><code>// abc.js\nvar a = 1;\nvar b = 2;\nvar c = 3;\nexport {a, b, c}\n\n//main.js\nimport {a, b, c} from \'./abc\';\nconsole.log(a, b, c);</code></pre><p>如果想为导入的变量重新取一个名字，使用as关键字（也可以在导出中使用）。</p><pre><code>import {a as aa, b, c};\nconsole.log(aa, b, c)</code></pre><p>如果想在一个模块中先输入后输出一个模块，import语句可以和export语句写在一起。</p><pre><code>import {a, b, c} form \'./abc\';\nexport {a, b,  c}\n\n// 使用连写, 可读性不好，不建议\nexport {a, b, c} from \'./abc\';</code></pre><p>模块的整体加载\n<br>\n<br>使用*关键字。</p><pre><code>// abc.js\nexport var a = 1;\nexport var b = 2;\nexport var c = 3;\n// main.js\nimport * from as abc form \'./abc\';\nconsole.log(abc.a, abc.b, abc.c);</code></pre><p><h1>export default\n</h1>\n<br>在export输出内容时，如果同时输出多个变量，需要使用大括号{}，同时导入也需要大括号。使用export defalut输出时，不需要大括号，而输入（import）export default输出的变量时，不需要大括号。</p><pre><code>// abc.js\nvar a = 1, b = 2, c = 3;\nexport {a, b};\nexport default c;\nimport {a, b} from \'./abc\';\nimport c from \'./abc\'; // 不需要大括号\nconsole.log(a, b, c) // 1 2 3</code></pre><p>本质上，export default输出的是一个叫做default的变量或方法，输入这个default变量时不需要大括号。</p><pre><code>// abc.js\nexport {a as default};\n\n// main.js\nimport a from \'./abc\'; // 这样也是可以的\n\n// 这样也是可以的\nimport {default as aa} from \'./abc\';\nconsole.log(aa);</code></pre><p>就到这里了吧。关于循环加载（模块相互依赖）没写，CommonJS和ES6处理方式不一样。</p>', '1501385762', 'guxiangyuan', '0', '0', '0', '');
INSERT INTO `article_table` VALUES ('12', '在JAVA中 String两种赋值方式区别', '对于JAVA中字符串的深入理解，虽然基础，但是基础是以后盖房子最好的砖块', '<p><!--StartFragment-->String 有两种方式赋值，一种是直接赋值，一种是通过构造方法赋值&nbsp;<br>1.String 第一种赋值方法 ，直接赋值：<!--EndFragment-->&nbsp;</p><pre><code>String s = \"Hello Java\";</code></pre><p>这种方式赋值，可以看作是”Hello Java”在堆内存中首先开辟了一个空间，在把空间地址赋值给了String s 对象. \n<br>也可以把”Hello Java”看作是String类的匿名对象，创建对象s，并把地址值赋给了s,s再指向”Hello Java”. \n<br>如下可以验证”Hello Java”是匿名对象</p><pre><code>public calss Demo{\n  public static void main(String [] agrs){\n  System.out.println(\"Hello Java\".equals(\"Hello java\"));//输出为false \n}\n}</code></pre><p>由此可以看出”Hello Java”为一个匿名对象 因为他可以调用equals()方法 \n<br>当然用这种方法来赋值最大的好处，是他在堆内存中开辟了一个空间，无论栈空间有多少个String 对象需要引用他都不用在堆内存中重新创建一个新的空间来重新将新的地址给对象 \n<br>上面解释如下代码</p><pre><code>public calss Demo{\n  public static void main(String [] agrs){\n  String str = \"Hello Java\";\n  String str1 = \"Hello Java\";\n  String str2 = \"Hello Java\";\n  String str3 = \"Hello Java\";\n  System.out.println(str == str1);//true\n  System.out.println(str1 == str2);//true\n  System.out.println(str2 == str3);//true\n}\n}</code></pre><p>由此可见他们的地址值都是一样的所有猜都为true. \n<br>2.String第二种赋值方法，用new String()构造方法来赋值 \n<br>具体代码：</p><pre><code>public calss Demo{\n  public static void main(String [] agrs){\n String str = new String(\"Hello Java\");\n System.out.println(str);//Hello java\n}\n}</code></pre><p>这种方式就是直接用String类的构造方法来赋值，这种方式用了new关键字，所以无论是创建几次对象都是需要重新在堆内存中创建新的内存空间，这样堆内存空间就会被占用很多，并且他们每个对象所引用的地址值都不一样，代码如下：</p><pre><code>public calss Demo{\n  public static void main(String [] agrs){\n  String str = new String(\"Hello Java\");\n  String str1 =new String(\"Hello Java\");\n  String str2 =new String(\"Hello Java\");\n  String str3 =new String(\"Hello Java\");\n  System.out.println(str == str1);//false\n  System.out.println(str1 == str2);//false\n  System.out.println(str2 == str3);//false\n}\n}</code></pre><p>所以这种方法远不如第一种直接赋值来的直接快速，并且不占用内存空间，所以推荐用第一种赋值方式\n<br>\n<br>补充： \n<br>String 类进行操作的时候有个特别重要的特性： \n<br>也就是字符串一旦被赋值就不能再被改变，即使是在输出上是被改变了字符串的输出打印，但是内存空间是重新开辟了一个新的字符串空间，以前的字符串并没有被改变，而且以前的字符串还是在内存池中。</p><p>&nbsp;<br></p>', '1501386139', 'guxiangyuan', '0', '1', '0', '');

-- ----------------------------
-- Table structure for banner_table
-- ----------------------------
DROP TABLE IF EXISTS `banner_table`;
CREATE TABLE `banner_table` (
  `ID` int(11) unsigned NOT NULL,
  `title` varchar(300) NOT NULL COMMENT '大标题',
  `description` varchar(300) NOT NULL COMMENT '摘要',
  `href` varchar(300) NOT NULL COMMENT '点击链接',
  `post_time` int(11) NOT NULL,
  `author` varchar(32) NOT NULL COMMENT '用户标志',
  `year` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='这是专门存储最近发布文章的表';

-- ----------------------------
-- Records of banner_table
-- ----------------------------
INSERT INTO `banner_table` VALUES ('5', '对于用JS无法清除Cookie的解决方法', '这个也是cookie的一个基础知识，关于cookie 设置域（domain），过期时间（expires），路径（path），后也要按照相同的方法来删除cookie', '/home/guxiangyuan/article/detail/4', '1501384144', 'guxiangyuan', '2017');
INSERT INTO `banner_table` VALUES ('7', '单页应用SEO浅谈', '单页应用（Single Page Application）越来越受web开发者欢迎，单页应用的体验可以模拟原生应用，一次开发，多端兼容。单页应用并不是一个全新发明的技术，而是随着互联网的发展，满足用户体验的一种综合技术。', '/home/guxiangyuan/article/detail/6', '1501384889', 'guxiangyuan', '2017');
INSERT INTO `banner_table` VALUES ('11', 'javascript模块化之CommonJS、AMD、CMD、UMD、ES6', '随着网站逐渐变成”互联网应用程序”，嵌入网页的JavaScript代码越来越庞大，越来越复杂。网页越来越像桌面程序，需要一个团队分工协作、进度管理、单元测试等等……开发者不得不使用软件工程的方法，管理网页的业务逻辑。javascript模块化编程，已经成为一个迫切的需求。理想情况下，开发者只需要实现核心的业务逻辑，其他都可以加载别人已经写好的模块。', '/home/guxiangyuan/article/detail/8', '1501385833', 'guxiangyuan', '2017');
INSERT INTO `banner_table` VALUES ('12', '在JAVA中 String两种赋值方式区别', '对于JAVA中字符串的深入理解，虽然基础，但是基础是以后盖房子最好的砖块', '/home/guxiangyuan/article/detail/12', '1501386139', 'guxiangyuan', '2017');

-- ----------------------------
-- Table structure for custom_evaluation_table
-- ----------------------------
DROP TABLE IF EXISTS `custom_evaluation_table`;
CREATE TABLE `custom_evaluation_table` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户评价',
  `title` varchar(32) NOT NULL COMMENT '标题',
  `description` varchar(200) NOT NULL COMMENT '评价详情',
  `src` varchar(300) NOT NULL COMMENT '用户头像',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='用户评价表';

-- ----------------------------
-- Records of custom_evaluation_table
-- ----------------------------

-- ----------------------------
-- Table structure for extra_table
-- ----------------------------
DROP TABLE IF EXISTS `extra_table`;
CREATE TABLE `extra_table` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `content` text,
  `original_Reprinted` int(11) DEFAULT NULL,
  `overview` varchar(255) DEFAULT NULL,
  `act` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='这是文章编辑器立即临时保存的表';

-- ----------------------------
-- Records of extra_table
-- ----------------------------

-- ----------------------------
-- Table structure for images_table
-- ----------------------------
DROP TABLE IF EXISTS `images_table`;
CREATE TABLE `images_table` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL COMMENT '图片的标题',
  `url` varchar(300) NOT NULL COMMENT '图片地址',
  `username` varchar(32) NOT NULL COMMENT '不通用户IP不同，且IP等于其注册的uername',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='这是存储图片的表';

-- ----------------------------
-- Records of images_table
-- ----------------------------

-- ----------------------------
-- Table structure for user_table
-- ----------------------------
DROP TABLE IF EXISTS `user_table`;
CREATE TABLE `user_table` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `avatar` varchar(255) NOT NULL COMMENT '头像',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of user_table
-- ----------------------------
INSERT INTO `user_table` VALUES ('19', 'guxiangyuan', 'ef09e95d52ebf43bce51be5aa1fb672d', '85ff420d2d3d546bed0b785c36bc55bd.jpg');
INSERT INTO `user_table` VALUES ('21', 'guxiangyuan11', 'ef09e95d52ebf43bce51be5aa1fb672d', '80b7914365d263cd2f56e8bbe80e19d3.jpg');
