<template>
  <div class="list-articles">
    <div>
      <!--loading....-->
      <transition name="loading-fade">
        <div class="loading-box" v-show="false">
          <div class="loading"></div>
        </div>
      </transition>
      <div class="list-articles-left">
        <div class="overlay"></div>
        <div class="back" >
          <ul style=" list-style:none;padding: 0;margin: 0; font-size: 18px;line-height: 38px;">
            <li class="">
              <router-link :to="{path:'/home/' + getUsername +'/article'}">
                <a class="glyphicon glyphicon-home "></a>
              </router-link>

            </li>
          </ul>
        </div>
        <div class="name">
          <span class="animated fadeInLeft">WEB</span>
          <h2 class="animated fadeInLeft">孤香远</h2>
        </div>
        <div></div>
      </div>
      <div class="list-articles-right" v-for="banner in banners">
        <div class="list">
          <!--头像-->
          <img :src=avatarUrl alt="头像" class="avatar">
          <div class="banner">
            <!--时间-->
            <span>{{getTime(banner.post_time)}}</span>
            <!--标题-->
            <h2>
              <router-link :to="{path: banner.href}">
                <a>{{banner.title}}</a>
              </router-link>
            </h2>
            <!--简介-->
            <p>{{banner.description}}</p>
          </div>
        </div>
      </div>
    </div>
    <div class="backTop" v-show="fade">
      <span @click="goTop" class="glyphicon glyphicon-chevron-up icon"></span>
    </div>
  </div>
</template>

<script>
  import {scrollToTop} from '../../../common/js/scrollToTop';
  import date from '../../../common/js/date';
  export default{
    data() {
      return {
          fade: false,
          scroll: '',
          banners: [],
          avatar: ''
      };
    },
    created() {
      var bannerRes = this.axios.get('/home/article?id=' + this.$route.params.id);
      var avatarRes = this.axios.get('/user/usermessage?name=' + this.$route.params.username);
      this.axios.all([bannerRes, avatarRes]).then(this.axios.spread((banner, avatar) => {
        // 两个请求现已完成
        this.banners = banner.data;
        this.avatar = avatar.data[0];
      })).catch((err) => {
          console.log(err);
      });
    },
    mounted() {
        // 实现滚动监听
      window.addEventListener('scroll', this.menu);
    },
    computed: {
      avatarUrl: function () {
        const URL = '../../../../static/upload/';
        return URL + this.avatar.avatar;
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
      }
    },
    methods: {
      getTime: function (time) {
        return date.timeDate(time);
      },
      menu() {
        this.scroll = document.body.scrollTop;
        if (this.scroll >= 300) {
            this.fade = true;
        } else {
          this.fade = false;
        }
      },
      goTop() {
        scrollToTop(300);
      }
    }
  };
</script>

<style>
  ::selection {
    background:#FC5185;
    color:#fff;
  }
  .list-articles{
   position: relative;
  }
  .list-articles a{
    text-decoration: none;
    color: #000;
  }
   .list-articles .loading-box{
     position: fixed;
     z-index: 100;
     height: 100%;
     width: 100%;
     background-color: #fff;
   }
  .list-articles .loading-box .loading{
    position: fixed;
    top:50%;
    left:50%;
    width: 100%;
    height: 100%;
    margin: -50px 0 0 -50px;
    background: url('./loader.gif') no-repeat;
  }
  .list-articles-left{
    width: 38.2%;
    position: fixed;
    height: 100%;
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center center;
    background-image: url('./3_bg.jpg');
  }
  .list-articles-left .overlay{
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 10;
    background: rgba(0, 0, 0, 0.5);
  }
  .list-articles-left .back{
    z-index: 12;
    position: absolute;
    bottom: 0;
    padding: 30px;
    top: 0;
    bottom: inherit !important;
  }
  .list-articles-left .back a{
    font-size: 14px;
    text-transform: uppercase;
    position: relative;
    height: 30px;
    width: 30px;
    display: block;
    text-align: center;
    line-height: 30px;
    text-decoration: none;
    color: #4cae4c;
  }
  .list-articles-left .back a:hover{
    color: #ac2925;
  }
  .list-articles-left .name{
    z-index: 12;
    position: absolute;
    bottom: 0;
    padding: 30px;
  }
  .list-articles-left .name span{
    display: block;
    color: rgba(255, 255, 255, 0.5);
    text-transform: uppercase;
    font-size: 15px;
    letter-spacing: .05em;
    margin-bottom: 10px;
  }
  .list-articles-left .name h2{
    font-size: 30px;
    color: #fff;
    font-weight: 300;
    font-family: "Work Sans", Arial, sans-serif;
    margin: 0 0 30px 0;
  }
  .list-articles-right{
    margin-left: 38.1966%;
    position: relative;
    z-index: 999;
  }
  .list-articles-right .list{
    padding: 50px;
    float: left;
    width: 100%;
    border-bottom: 1px solid #f2f2f2;
  }
  .list-articles-right .list img{
    float: right;
    width: 10%;
    border: 0;
    margin-bottom: 30px;
    vertical-align: middle;
    -webkit-border-radius: 50%;
    -moz-border-radius: 50%;
    -ms-border-radius: 50%;
    border-radius: 50%;
  }
  .list-articles-right .list .banner{
    width: 77%;
    float: left;
    margin-right: 5%;
    margin-top: 0px;
  }
  .list-articles-right .list .banner span{
    color: #b3b3b3;
    margin-bottom: 10px;
    display: block;
    text-transform: uppercase;
    font-weight: 100;
    letter-spacing: .05em;
  }
  .list-articles-right .list .banner h2{
    margin-bottom: 10px;
    font-weight: 100;
    font-size: 30px;
    color: #000;
    font-family: "Work Sans", Arial, sans-serif;
    margin: 0 0 30px 0;
  }
  .list-articles-right .list .banner p{
    margin-bottom: 0;
    font-size: 18px;
    line-height: 38px;
    margin: 0 0 10px;
  }
  .list-articles-right .list .banner a:hover{
    color:#FC5185;
  }
 .list-articles .backTop{
   position: fixed;
   z-index: 999;
   bottom: 10px;
   right: 30px;
   background-color: rgba(255,255,255,0.5);

 }
  .list-articles .backTop  span{
    line-height: 50px;
    text-align: center;
    width: 50px;
    height: 50px;
    border-radius: 5px;
    background-color: rgba(0,0,0,0.1);
  }
  .list-articles .backTop span:hover{
    background-color: rgba(0,0,0,.5);
    cursor: pointer;
  }
  .loading-fade-enter-active,.loading-fade-leave-active{
    transition: all .2s;
  }
  .loading-fade-enter,.loading-fade-leave-to{
    opacity: 0;
  }
</style>
