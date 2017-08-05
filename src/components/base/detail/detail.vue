<template>
  <div class="detail">
    <div v-show="show">
      <!--作者信息-->
      <div class="detail-user">
        <span @click="toArticle" class="glyphicon glyphicon-chevron-left icon"></span>
        <img src="./bg.jpg" alt="">
        <div class="detail-user-avatar">
          <img src="./9.jpg" alt="">
          <p>{{article.author}}</p>
          <span>发布日期：{{getDate}}</span>
        </div>
        <button class="btn btn-default button" @click="toEditor">编辑文章</button>
      </div>
      <!--文章-->
      <div class="detail-article" ref="article">
        <h1><span v-show="reprinted">【转】</span><span v-show="original">【原】</span>{{article.title}}</h1>
        <blockquote v-show="article.overview">
          <p>作者简介：{{article.overview}}</p>
        </blockquote>
        <!--// 返回顶部-->
        <div class="backTop" v-show="fade"><span @click='toTop()' class="glyphicon glyphicon-chevron-up icon"></span></div>
        <div v-html="article.content"></div>
      </div>
      <!--点赞-->
      <div class="praise">
        <div class="up-praise">
          <span class="glyphicon glyphicon-thumbs-up"></span>
          <p>{{article.up_praise}}</p>
        </div>
        <div class="low-praise">
          <span class="glyphicon glyphicon-thumbs-down"></span>
          <p>{{article.low_praise}}</p>
        </div>
      </div>
    </div>
    <transition name="detail-editor">
      <detailEditor v-show="detailEd"></detailEditor>
    </transition>

  </div>
</template>

<script>
  /* eslint-disable eqeqeq */
  import detailEditor from '../../../components/base/detail/detail_editor.vue';
  import {scrollToTop} from '../../../common/js/scrollToTop';
  import date from '../../../common/js/date';
  export default{
    data() {
      return {
        scroll: '',
        article: {},
        original: false,
        reprinted: false,
        fade: false,
        ID: '',
        show: true,
        detailEd: false
      };
    },
    components: {
      detailEditor
    },
    created() {
      this.ID = this.$route.params.id;
      // 请求文章的数据
      this.axios.get('/home/article/detail?id=' + this.$route.params.id).then((res) => {
        this.article = res.data[0];
      }).catch((err) => {
        console.log(err);
      });
    },
    mounted() {
      this.show = true;
      window.addEventListener('scroll', this.menu, false);
    },
    computed: {
      getDate () {
        if (this.article.original_Reprinted === 0) {
          this.original = false;
          this.reprinted = true;
        } else {
          this.original = true;
          this.reprinted = false;
        }
        return date.timeDate(this.article.post_time);
      }
    },
    methods: {
      toTop() {
        scrollToTop(300);
      },
      menu() {
        this.scroll = document.body.scrollTop;
        if (this.scroll >= 300) {
          this.fade = true;
        } else {
          this.fade = false;
        }
      },
      toEditor() {
        this.show = false;
        this.detailEd = true;
      },
      getUsername: function () {
        // 如果页面刷新判断是否有username
        if (this.$store.state.username) {
          return this.$store.state.username;
        } else {
          // 如果没有，就在localstorage上取值
          let username = window.localStorage.USERNAME;
          this.$store.commit('reciveName', username);
          return this.$store.state.username;
        }
      },
      toArticle() {
        this.$router.go(-1);
      }
    }
  };
</script>

<style>
  .detail-article{
    position: relative;
    z-index: 603;
    margin: 0 auto;
    width: 1090px;
    overflow: auto;
    padding:0 20px 50px 0;
    background-color: #fff;
  }
  .detail-user{
    width: 100%;
    position: relative;
  }
  .detail-user .button{
    position:absolute;
    right: 406px;
    bottom:0px;
  }
  .detail-user img{
    display: block;
    width: 1090px;
    height: 220px;
    margin: 0 auto;
  }
  .detail-user .detail-user-avatar{
    position: absolute;
    bottom: 40px;
    left: 45%;
    margin: 0 -50% 0 0;
  }
  .detail-user .detail-user-avatar img {
    margin-bottom: 20px;
    width: 80px;
    height: 80px;
    border-radius: 50%;
  }
  .detail-user .detail-user-avatar span{
    display: inline-block;
    color: #ffffff;
  }
  .detail-user .detail-user-avatar p {
    margin: 0  auto;
    padding-left: 54px;
    color: #ffffff;
  }
  .detail-user .icon{
    position: absolute;
    left:450px;
    top:20px;
    width: 30px;
    height: 30px;
    vertical-align: middle;
    line-height: 30px;
    text-align: center;
    border-radius: 50%;
    cursor: pointer;
    background-color: rgba(255,255,255,0.5);
  }
  .detail-article{
    position: relative;

  }
  .detail-article .backTop{
    position: fixed;
    bottom: 10px;
    right: 360px;
    background-color: rgba(255,255,255,0.5);
  }
  .detail-article .backTop span {
    line-height: 50px;
    text-align: center;
    width: 50px;
    height: 50px;
    border-radius: 5px;
    background-color: rgba(0,0,0,0.1);
  }
  .detail-article .backTop span:hover {
    background-color: rgba(0,0,0,.5);
    cursor: pointer;
  }
  .detail .praise{
    width: 300px;
    margin: 0 auto;
    margin-bottom: 30px;
    text-align: center;
    color: #fff;
  }
  .detail .praise .up-praise,.detail .praise .low-praise{
    display: inline-block;
    width: 80px;
    height: 80px;
    background-color: #999;
    border-top: none;
    margin-right: 20px;
  }
  .detail .praise .up-praise span,.detail .praise .low-praise span{
    width: 100%;
    height: 40px;
    font-size: 20px;
    line-height: 40px;
  }
  .detail .praise .up-praise p,.detail .praise .low-praise p{
    display: inline-block;
    font-size: 20px;
  }
  .detail-editor-enter-active,.detail-editor-leave-active{
    -webkit-transition: all .8s;
    -moz-transition: all .8s;
    -ms-transition: all .8s;
    -o-transition: all .8s;
    transition: all .8s;
  }

  .detail-editor-enter,.detail-editor-leave-to{
    opacity:0;
    transform: translateY(100%);
  }
</style>
