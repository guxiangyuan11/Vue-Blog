<template>
  <div id="app">
    <!--欢迎标题-->
    <div v-show="!Login">
      <div class="welcome">
        <div class="animated  flash welcome-text">
          welcomeBlog
        </div>
      </div>
      <div class="login-username">
        <login @loginBlog="isLogin"></login>
      </div>
    </div>
     <transition name="home-fade">
       <router-view v-show="Login"></router-view>
     </transition>
    <div>{{user_ok}}</div>
  </div>

</template>

<script>
  import login from './components/base/login/login.vue';
  export default {
    data () {
      return {
        Login: false,
        username: ''
      };
    },
    mounted() {
      // 判断当前有没有cookie，如果有就直接跳转到用户
      var value = document.cookie.split('=')[1];
      if (value) {
        this.Login = true;
        this.$router.push({path: '/home/' + window.localStorage['USERNAME']});
      }
    },
    computed: {
        user_ok() {
          var value = document.cookie.split('=')[1];
          if (value) {
            this.Login = true;
            this.$router.go(1);
          }
        }
    },
    methods: {
        isLogin: function (data) {
        this.Login = data[0];
        this.username = data[1];
      }
    },
    components: {
        login
      }
  };
</script>

<style >
  .welcome{
    width: 100%;
    display: inline-block;
    text-align: center;

  }
.welcome-text{
  display: inline-block;
  margin-top: 130px;
  color: green;
  font-size: 60px;
  font-family: '微软雅黑';
  background-image: -webkit-gradient(linear, 0 0, 0 bottom, from(rgba(236, 201, 81, 0.5)), to(rgba(51, 51, 51, 1)));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  -webkit-animation-duration:6s;
  -webkit-animation-delay:1s;
  -webkit-animation-iteration-count:infinite;
}
  .login-username{
    margin-top: 30px;
    width: 100%;
    text-align: center;
  }
  .home-fade-enter-active,.home-fade-leave-active {
    transition: all .3s;
  }
  .home-fade-enter,.home-fade-leave-to{
    opacity: 0;
  }
</style>
