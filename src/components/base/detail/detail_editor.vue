<template>
  <div class="editor-box">
    <div class="editor">
      <!--文章标题-->
      <div class="form-group">
        <label for="exampleInputText">文章标题</label>
        <input v-model="editor_title" type="text" class="form-control" id="exampleInputText" placeholder="文章标题">
      </div>
      <!--是否原创-->
      <div class="checkbox">
        <label>
          <input v-model="editor_original_Reprinted" type="radio" name="chooes" value="oragin">原创
        </label>
        <label>
          <input v-model="editor_original_Reprinted" type="radio" name="chooes" value="reprint">转载
        </label>
      </div>
      <!--文章内容-->
      <div id="editorElem" style="text-align:left"></div>
      <div class="Label">
        <label>摘要:（最多200个字）<span v-show="descriptions" style="color: red;">已经超出200字!</span></label>
        <textarea v-model="editor_description" class="form-control" rows="3"></textarea>
        <span></span>
      </div>
      <div class="Label">
        <label>作者简介：（如果是转载可加上作者简介，如果没有可不写）</label>
        <textarea v-model="editor_overview" class="form-control" rows="2"></textarea>
      </div>
    </div>
    <!--发布-->
    <div class="button">
      <button class="btn btn-default btn-primary" type="submit">修改</button>
      <button class="btn btn-default btn-danger" type="submit">返回</button>
    </div>
  </div>
</template>

<script>
  /* eslint-disable no-unused-vars,no-multiple-empty-lines,no-trailing-spaces */
  import E from 'wangeditor';
  import date from '../../../common/js/date';
  import {scrollToTop} from '../../../common/js/scrollToTop';
  export default {
    name: 'editor',
    data () {
      return {
        editorContent: '',
        editor_title: '', // 文章标题 必须
        editor_original_Reprinted: '', // 文章是否原创 必须
        editor_author: this.$route.params.username, // 作者名 必须
        editor_post_time: 0, // 发布时间 必须
        editor_content: '', // 文章内容 必须
        editor_overview: '', // 作者简介 可以null
        editor_year: 0, // 发布的年份 必须
        editor_href: '', // 附带文章的链接 必须
        editor_description: '', // 摘要 必须
        time: '', // 修改时间
        ID: '', // 发送当前ID
        descriptions: false
      };
    },
    methods: {
    },
    created() {
    },
    mounted() {
      // editor 编辑器 简单好用
      var editor = new E('#editorElem');
      editor.customConfig.onchange = (html) => {
        this.editorContent = html;
      };
//        editor.customConfig.uploadImgServer = '/upload';
      editor.customConfig.uploadImgMaxSize = 3 * 1024 * 1024;
      editor.customConfig.uploadImgShowBase64 = true;
      editor.customConfig.debug = false;
      editor.create();
      this.ID = this.$route.params.id;
      this.axios.get('/home/article/detail?id=' + this.ID).then((res) => {
        let response = res.data[0];
        this.editor_title = response.title;
        this.editor_content = response.content;
        this.editor_overview = response.overview;
        editor.txt.html(this.editor_content);
        this.editor_description = response.summary;
        if (response.original_Reprinted === 0) {
          this.editor_original_Reprinted = 'reprint';
        } else {
          this.editor_original_Reprinted = 'oragin';
        }
      }).catch((err) => {
        console.log(err);
      });
      // 修改编辑按钮
      document.getElementsByClassName('btn-primary')[0].addEventListener('click', () => {
        // 需要发送2个post请求
        // post请求分别发送至存储文章和banner
        this.editor_content = editor.txt.html();
        var nowDate = date.gettime();
        var year = date.timeYear().year;
        var href = '/home/' + this.$route.params.username + '/article/detail/' + this.ID;
        if (this.editor_description.length >= 201) {
          this.descriptions = true;
        } else {
          if (this.editor_title && this.editor_original_Reprinted && this.editor_content && this.editor_description) {
            var a = -1;
            if (this.editor_original_Reprinted === 'oragin') {
              a = 1;
            } else {
              a = 0;
            }
            // 文章
            var article = this.axios.post('/home/article/mod', {
              title: this.editor_title.replace(/'/g, "''").replace(/(^\s*)|(\s*$)/g, ''),
              content: this.editor_content.replace(/'/g, "''"),
              overview: this.editor_overview.replace(/'/g, "''"),
              summary: this.editor_description.replace(/'/g, "''"),
              up_praise: 0,
              low_praise: 0,
              original_Reprinted: a,
              author: this.$route.params.username,
              post_time: nowDate,
              ID: this.ID
            });
            // 最近发布
            var banners = this.axios.post('/home/article/banner/mod', {
              title: this.editor_title.replace(/'/g, "''").replace(/(^\s*)|(\s*$)/g, ''),
              description: this.editor_description.replace(/'/g, "''"),
              author: this.$route.params.username,
              post_time: nowDate,
              year: year, //
              href: href,
              ID: this.ID
            });
            this.axios.all([article, banners]).then(this.axios.spread((deleteExtrares, articleres, bannersres) => {
              this.$router.go(-1);
            })).catch((err) => {
              console.log(err);
            });
          } else {
            window.alert('发布的文章不完整，还有的没填哦！');
          }
        }
      }, false);
      // 舍弃
      document.getElementsByClassName('btn-danger')[0].addEventListener('click', () => {
        console.log('a');
        if (this.editor_title || this.editor_content || this.editor_description) {
          if (window.confirm('确定要舍弃已编写文章')) {
            this.$router.go(-1);
          }
        } else {
          return;
        }
      }, false);
    }
  };
</script>

<style scoped>
  .editor{
    width: 1000px;
    margin: 50px auto;
  }
  .editor .checkbox label{
    padding-left: 0;
  }
  .editor .checkbox .draft{
    margin-left: 50px;
    color: red;
  }
  .editor .Label label{
    display: block;
    color: #8c8c8c;
  }
  .editor .Label input{
    display: inline;
    width: 70%;
  }
  .editor-box .button{
    width: 300px;
    margin: 70px auto;
  }
  .editor-box .button button{
    margin-right: 30px;
  }
</style>
