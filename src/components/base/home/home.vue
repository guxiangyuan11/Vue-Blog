<template>
  <div class="home-bg" :style="{position: none, backgroundImage: bgImg}" >
    <div class="box" :style="{zIndex:getzIndex}" v-show="isId">
      <div class="login-out" >
        <!--下拉框-->
        <button @click="menu = !menu" class="btn btn-default dropdown-toggle btn-xs" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" v-show="isVisitor">
          Dropdown
          <span class="caret"></span>
        </button>
        <transition name="menu-fade">
          <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" v-show="menu">
            <li>
              <router-link :to="{path: '/home/'+getUsername+'/editor/-1'}">
                <a>编辑新文章</a>
              </router-link>
            </li>
            <li><a href="#">个人设置</a></li>
            <li role="separator" class="divider"></li>
          </ul>
        </transition>
        欢迎 {{getUsername}} <a @click="clearCookie">{{StringName}}</a>
      </div>
      <div class="row">
        <nav class="navbar navbar-inverse">
          <!-- We use the fluid option here to avoid overriding the fixed width of a normal container within the narrow content columns. -->
          <div class="container-fluid nav-title">
            <div class="navbar-header col-sm-5 ">
              <router-link :to="{path:'/home/'+getUsername}">
                <a class="navbar-brand icon-glyphicon-fire" :href="'/home/'+getUsername" ><span class="glyphicon glyphicon-fire"></span>Fire</a>
              </router-link>
            </div>
            <div class="collapse navbar-collapse col-sm-7" id="bs-example-navbar-collapse-6">
              <ul class="nav navbar-nav nav-ul">
                <router-link :to="{path:'/home/'+getUsername+'/Reason'}" tag="li"><a href="#" >主页</a></router-link>
                <router-link :to="{path:'/home/'+getUsername+'/article'}" tag="li"><a href="#" >博客文章</a></router-link>
                <router-link :to="{path:'/home/'+getUsername+'/image'}" tag="li"><a href="#" >照片</a></router-link>
              </ul>
            </div><!-- /.navbar-collapse -->
          </div>
        </nav>
      </div>
    </div>
    <div class="all" @click="menu = false">
      <transition name="left">
        <keep-alive>
          <router-view></router-view>
        </keep-alive>
      </transition>
    </div>
    <transition name="warning-fade">
      <div class="warning" v-show="isId" >
        <p class="animated fadeInLeft">每天不管是天堂还是地狱</p>
        <p class="animated fadeInRight">只要活着,快乐就是赚了---me</p>
      </div>
    </transition>
  </div>
</template>

<script>
  import cookieApi from '../../../common/js/cookie';
  export default{
    data () {
      return {
        username: '',
        fade: true,
        out: false,
        isId: true,
        none: 'fixed',
        bgImg: 'url(../../../../static/home_bg.jpg)',
        menu: false,
        StringName: '[退出]',
        isVisitor: true
      };
    },
    created() {
      let username = this.$route.params.username;
      if (username === 'undefined') {
        cookieApi.delCookie('user');
        this.$router.push('/');
      }
      if (username === 'visitor') {
        this.StringName = '[登录]';
        this.isVisitor = false;
      } else {
        this.StringName = '[退出]';
        this.isVisitor = true;
      }
    },
    computed: {
      getzIndex() {
        if (this.$route.params.id) {
          this.isId = false;
          this.none = 'absolute';
          this.bgImg = 'url("")';
          return 0;
        } else {
          this.isId = true;
          this.none = 'fixed';
          this.bgImg = 'url(../../../../static/home_bg.jpg)';
          return 601;
        }
      },
      getUsername: function () {
        if (this.fade) {
          setTimeout(() => {
            this.fade = false;
          }, 3500);
        }
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
      clearCookie() {
        cookieApi.delAllCookie();
        window.localStorage.clear();
        this.$router.go(0);
      }
    }
  };
</script>

<style>
  .home-bg{
    /*background-image: url('../../../../static/home_bg.jpg');*/
    width: 100%;
    height: 100%;
    position: fixed;
  }
  .home-bg .all{
    position: relative;
    z-index: 600;
  }
  .home-bg .warning{
    position: relative;
    width: 1000px;
    height: 1000px;
    left: 350px;
    z-index: 500;
  }
  .home-bg .warning p{
    font-weight: 700;
    font-family:Arial,Verdana,Sans-serif;
    font-size: 60px;
    color: #ffffff;
  }
  .home-bg .warning p:nth-child(1){
    margin-top: 180px;
    -webkit-animation-duration:2s;
    -webkit-animation-delay:.2s;
    -webkit-animation-iteration-count: 1;
  }
  .home-bg .warning p:nth-child(2){
    margin-top: 40px;
    text-indent: 3em;
    -webkit-animation-duration:2s;
    -webkit-animation-delay:.2s;
    -webkit-animation-iteration-count: 1;
  }
  .warning-fade-enter-active,.warning-fade-leave-active{
    transition:all .2s;
  }
  .warning-fade-enter,.warning-fade-leave-to{
    opacity: 0;
  }
  .box{
    position: relative;
    z-index: 601;
  }
  .icon-glyphicon-fire{
    height: 112px;
    line-height: 84px;
    font-size: 58px;
    color: #000;
  }
  .nav-ul li a{
    width: 152px;
    height: 112px;
    line-height: 84px;
    font-size: 20px;
    font-weight: 600;
  }
  .navbar-inverse{
    margin-top: 30px;
    padding-left: 60px;
    margin-right: 31px;
    background-color: rgba(255,255,255,0.3);
    border-color: rgba(255,255,255,0.1);
  }

  .login-out{
    position: absolute;
    width:100%;
    height: 30px;
    right:20px;
    text-align: right;
    line-height: 30px;
    color: #FEFFED;
  }
  .login-out ul{
    display: block;
    left:1590px;
    right: 152px;

  }
  .navbar-inverse .navbar-nav>li{
    text-align: center;
  }
  .navbar-inverse .navbar-nav>li>a{
    color: #000;
  }
  .navbar-inverse .navbar-nav>li>a:hover{
    background-color: rgba(255,255,255,0.8);
    color: #337ab7;
  }
  .navbar-inverse .navbar-nav>li>a.active{
    background-color: #000000;
  }
  .left-enter-active,.left-leave-active{
    transition: all 0.5s;
  }
  .left-enter{
    transform: translateX(100%);
    opacity:0;
  }
  .left-leave-to{
    transform: translateX(-100%);
    opacity:0;
  }
  .menu-fade-enter-active,.menu-fade-leave-active{
    transition: all .4s;
  }
  .menu-fade-enter,.menu-fade-leave-to{
    transform:translateY(40px);
    opacity: 0;
  }
</style>
