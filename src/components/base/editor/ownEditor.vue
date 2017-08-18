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
        <span class="draft" v-show="save">草稿已经保存 时间: {{time}}</span>
      </div>
      <!--文章内容-->
      <div id="editorElem" style="text-align:left"></div>
      <!--文章标签-->
      <div class="Label">
        <label for="exampleInputLabel">文章标签</label>
        <input v-model="editor_summar" type="text" class="form-control" id="exampleInputLabel" placeholder="文章标签">
        <span>（最多添加5个标签，多个标签之间用“,”分隔）</span>
      </div>
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
      <button class="btn btn-default btn-primary" type="submit">发布</button>
      <button class="btn btn-default btn-warning save" type="submit">立即保存</button>
      <button class="btn btn-default btn-danger" type="submit">舍弃</button>
    </div>
  </div>
</template>

<script>
  /* eslint-disable no-unused-vars,no-multiple-empty-lines,no-trailing-spaces */

  import E from 'wangeditor';
  import date from '../../../common/js/date';
  export default {
    name: 'editor',
    data () {
      return {
        editorContent: '',
        editor_title: '', // 文章标题 必须
        editor_original_Reprinted: '', // 文章是否原创 必须
        editor_author: this.$route.params.username, // 作者名 必须
        editor_post_time: 0, // 发布时间 必须
        editor_summar: '', // 标签 必须
        editor_content: '', // 文章内容 必须
        editor_overview: '', // 作者简介 可以null
        editor_year: 0, // 发布的年份 必须
        editor_href: '', // 附带文章的链接 必须
        editor_description: '', // 摘要 必须
        save: false, // 存储成功标签
        time: '', // 时间
        ID: '', // 拿到最大的ID 设置文章的链接地址
        descriptions: false
      };
    },
    methods: {
    },
    created() {
    },
    mounted() {
      // editor 编辑器
      var editor = new E('#editorElem');
      editor.customConfig.onchange = (html) => {
        this.editorContent = html;
      };
//        editor.customConfig.uploadImgServer = '/upload';
      editor.customConfig.uploadImgMaxSize = 3 * 1024 * 1024;
      editor.customConfig.uploadImgShowBase64 = true;
      editor.customConfig.debug = false;
      editor.create();
      // 请求后台看是否有保存的数据传过来
      this.axios.get('/editor/extra').then((res) => {
        const response = res.data[0];
        if (res.data.success === 0) {
          return;
        } else {
          this.editor_title = response.title;
          this.editor_summar = response.summary;
          this.editor_content = response.content;
          this.editor_overview = response.overview;
          editor.txt.html(this.editor_content);
        }
      }).catch((err) => {
        console.log(err);
      });
      // 请求banner后台拿到最大的ID
      this.axios.get('/home/article/bannerID').then((res) => {
        this.ID = res.data[0]['MAX(ID)'] + 1;
      }).catch((err) => {
        console.error(err);
      });
      // 发布按钮
      document.getElementsByClassName('btn-primary')[0].addEventListener('click', () => {
        // 需要发送2个post请求和1个get请求
        // post请求分别发送至存储文章和banner
        // get请求发送至临时存储删除存储
        this.editor_content = editor.txt.html();
        const nowDate = date.gettime();
        const year = date.timeYear().year;
        const href = '/home/' + this.$route.params.username + '/article/detail/' + this.ID;
        if (this.editor_description.length >= 201) {
          this.descriptions = true;
        } else {
          if (this.editor_title && this.editor_original_Reprinted && this.editor_summar && this.editor_content && this.editor_description) {
            let a = -1;
            a = this.editor_original_Reprinted === 'oragin' ? 1 : 0;
            // 删除
            const deleteExtra = this.axios.get('/editor/delete');
            // 文章
            const article = this.axios.post('/home/article/add', {
              title: this.editor_title.replace(/'/g, "''").replace(/(^\s*)|(\s*$)/g, ''),
              content: this.editor_content.replace(/'/g, "''"),
              overview: this.editor_overview.replace(/'/g, "''"),
              summary: this.editor_description.replace(/'/g, "''"),
              up_praise: 0,
              low_praise: 0,
              original_Reprinted: a,
              author: this.$route.params.username,
              post_time: nowDate
            });
            // 最近发布
            const banners = this.axios.post('/home/article/banner', {
              title: this.editor_title.replace(/'/g, "''").replace(/(^\s*)|(\s*$)/g, ''),
              description: this.editor_description.replace(/'/g, "''"),
              author: this.$route.params.username,
              post_time: nowDate,
              year,
              href
            });
            this.axios.all([deleteExtra, article, banners]).then(this.axios.spread((deleteExtrares, articleres, bannersres) => {
              // 发布成功 这里应该有个成功的弹出框
              this.$router.go(-1);
            })).catch((err) => {
              console.log(err);
            });
          } else {
            window.alert('发布的文章不完整，还有的没填哦！');
          }
        }
      }, false);
      // 立即保存
      document.getElementsByClassName('save')[0].addEventListener('click', () => {
        const nowDate = date.gettime();
        const nowTime = date.timeDate(nowDate);
        if (this.editor_title || this.editor_summar || this.editor_content || this.editor_overview || this.editor_description) {
          this.editor_content = editor.txt.html();
          this.editor_title = this.editor_title.replace(/'/g, "''").replace(/(^\s*)|(\s*$)/g, '');
          this.editor_summar = this.editor_summar.replace(/'/g, "''");
          this.editor_content = this.editor_content.replace(/'/g, "''");
          this.editor_overview = this.editor_overview.replace(/'/g, "''");
          this.editor_description = this.editor_description.replace(/'/g, "''");
          this.axios.post('/editor', {title: this.editor_title, summar: this.editor_summar, content: this.editor_content, overview: this.editor_overview, description: this.editor_description}).then((res) => {
            this.time = nowTime;
            this.save = true;
          }).catch((err) => {
            this.save = false;
            console.log(err);
            window.alert('保存失败，请重新保存');
          });
        } else {
          this.save = false;
          window.alert('请输入内容再保存');
        };
      }, false);
      // 舍弃
      document.getElementsByClassName('btn-danger')[0].addEventListener('click', () => {
        if (this.editor_title || this.editor_summar || this.editor_content || this.editor_overview || this.editor_description) {
          if (window.confirm('确定要舍弃已编写文章')) {
            this.axios.get('/editor/delete').then((data) => {
              this.editor_title = '';
              this.editor_summar = '';
              this.editor_content = '';
              this.editor_overview = '';
              this.$router.go(-1);
            }).catch((err) => {
              console.log(err);
            });
          }
        } else {
          this.$router.go(-1);
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
    width: 500px;
    margin: 70px auto;
  }
  .editor-box .button button{
    margin-right: 40px;
  }
</style>
