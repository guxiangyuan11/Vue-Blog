<template>
  <div>
    <form class="form-horizontal" >
      <div class="form-group" :class="{'has-success':nameSuccess,'has-error':nameError}" >
        <label for="exampleInputName1" class="col-sm-5 control-label labelUser">用户名:</label>
        <div class="col-sm-2">
          <input v-model="username"  type="username" class="form-control username " id="exampleInputName1"  aria-describedby="helpBlock1" placeholder="username">
          <!--[if !IE]>
          <span class="glyphicon glyphicon-ok form-control-feedback icon-glyphicon-ok" v-show="nameSuccess" aria-hidden="true"></span>
          <span class="glyphicon glyphicon-remove form-control-feedback icon-glyphicon-ok" v-show="nameError" aria-hidden="true"></span>
          <![endif]-->
        </div>
        <span id="helpBlock1" class="col-sm-5 help-block helpText" >{{isUser()}}</span>

      </div>
      <div class="form-group " :class="{'has-success':wordSuccess,'has-error':wordError}">
        <label for="inputPassword3"  class="col-sm-5 control-label labelUser">密码:</label>
        <div class="col-sm-2">
          <input v-model="password" type="password" class="form-control password" id="inputPassword3"  aria-describedby="helpBlock2" placeholder="Password">
          <!--[if !IE]>
          <span class="glyphicon glyphicon-ok form-control-feedback icon-glyphicon-ok" v-show="wordSuccess" aria-hidden="true"></span>
          <span class="glyphicon glyphicon-remove form-control-feedback icon-glyphicon-ok" v-show="wordError" aria-hidden="true"></span>
          <![endif]-->
        </div>
        <span id="helpBlock2" class="col-sm-5 help-block helpText">{{isPass()}}</span>
      </div>
      <router-link :to="{path:'/home/'+this.username}">
        <button type="button" class="btn btn-warning loginBut" :class="{' btn-danger': btnDanger}" @click="loginBlog">登录</button>
      </router-link>
      <button type="button" class="btn btn-default" @click="goback">注册</button>
    </form>


    <transition name="fade">
      <div  class="bg" v-if="hiddden"></div>
    </transition>
    <!--注册-->
    <transition name="fade">
      <form class="form-horizontal reg" v-if="hiddden">

        <div class="form-group" :class="{'has-success':nameSuccess,'has-error':nameError}">
          <label for="exampleInputName3" class="col-sm-3 control-label labelUser">用户名:</label>
          <div class="col-sm-5">
            <input v-model="username" type="username" class="form-control username " id="exampleInputName3"  aria-describedby="helpBlock3" placeholder="username">
            <!--[if !IE]>
            <span class="glyphicon glyphicon-ok form-control-feedback icon-glyphicon-ok" v-show="nameSuccess" aria-hidden="true"></span>
            <span class="glyphicon glyphicon-remove form-control-feedback icon-glyphicon-ok"  v-show="nameError" aria-hidden="true"></span>
            <![endif]-->
          </div>
          <span id="helpBlock3" class="col-sm-4 help-block helpText">{{isUser()}}</span>
        </div>

        <div class="form-group"  :class="{'has-success':wordSuccess,'has-error':wordError}">
          <label for="inputPassword4" class="col-sm-3 control-label labelUser">密码:</label>
          <div class="col-sm-5">
            <input v-model="password" type="password" class="form-control password" id="inputPassword4"  aria-describedby="helpBlock4" placeholder="Password">
            <!--[if !IE]>
            <span class="glyphicon glyphicon-ok form-control-feedback icon-glyphicon-ok"  v-show="wordSuccess" aria-hidden="true"></span>
            <span class="glyphicon glyphicon-remove form-control-feedback icon-glyphicon-ok" v-show="wordError" aria-hidden="true"></span>
            <![endif]-->
          </div>
          <span id="helpBlock4" class="col-sm-4 help-block helpText">{{isPass()}}</span>
        </div>
        <div class="form-group" :class="{'has-success':wordSuccess2,'has-error':wordError2}">
          <label for="inputPassword4" class="col-sm-3 control-label labelUser">二次输入密码:</label>
          <div class="col-sm-5">
            <input v-model="password2" type="password" class="form-control password" id="inputPassword5"  aria-describedby="helpBlock5" placeholder="Password">
            <!--[if !IE]>
            <span class="glyphicon glyphicon-ok form-control-feedback icon-glyphicon-ok"   v-show="wordSuccess2" aria-hidden="true"></span>
            <span class="glyphicon glyphicon-remove form-control-feedback icon-glyphicon-ok" v-show="wordError2"  aria-hidden="true"></span>
            <![endif]-->
          </div>
          <span id="helpBlock5" class="col-sm-4 help-block helpText">{{isSame()}}</span>
        </div>
        <div class="form-group">
          <label for="exampleInputFile">上传头像</label>
          <input ref='asd' type="file" id="exampleInputFile" class="avatar"><img class="avatar-img" src="./9.jpg" alt="">
          <p class="help-block image-help">上传您的头像，尺寸不超过360X360，优化样式如上图</p>
        </div>
        <button type="button" class="btn btn-primary btn-lg btn-block regBut" @click="sign">注册</button>
        <button type="button" class="btn btn-defaul backBtn" @click="goback" >溜了溜了..</button>
      </form>
    </transition>
    <!--注册表单-->

  </div>
</template>

<script>
  /* eslint-disable handle-callback-err,no-unused-vars */

  import Regex from '../../../common/js/Regex';
  import MD5 from '../../../common/js/MD5';
  export default{
    data () {
      return {
        islogin: false,
        isSign: false,
        username: '',
        password: '',
        password2: '',
        originalUser: '',
        hiddden: false,
        nameSuccess: false,
        nameError: false,
        wordSuccess: false,
        wordError: false,
        wordSuccess2: false,
        wordError2: false,
        btnDanger: false,
        file: ''
      };
    },
    computed: {
      getUsname() {
        this.$store.commit('reciveName', this.username);
      }
    },
    methods: {
      submitImg(tag) {
        this.file = tag.files[0];
      },
      goback() {
        this.username = '';
        this.password = '';
        this.password2 = '';
        this.hiddden = !this.hiddden;
      },
      // 注册判断
      sign: function () {
        this.submitImg(this.$refs.asd);
        // 判断是否输入为空
        if (this.password2 && this.username) {
          // 判断是否都输入正确了
          if (this.wordSuccess && this.password && this.password2) {
            // 判断是否有上传的图片
            if (this.file) {
              // 判断是否是正确的图片格式
              if (/\.(png|jpg|gif)$/.test(this.file.name)) {
                var formData = new FormData();
                this.password2 = MD5.md5(this.password2);
                this.password = MD5.md5(this.password);
                formData.append('file', this.file);
                formData.append('username', this.username);
                formData.append('password', this.password2);
                let config = {
                  headers: {
                    'Content-Type': 'multipart/form-data'
                  }
                };
                this.axios.post('/user/sign', formData, config).then((res) => {
                  this.isSign = res.data.success;
                  this.username = '';
                  this.password2 = '';
                  this.password = '';
                  this.hiddden = !this.hiddden;
                }).catch((err) => {
                  this.isSign = false;
                  if (err.response) {
                    if (err.response.data.error === 5) {
                      window.alert('服务器忙请稍等再试试注册');
                    } else if (err.response.data.error === 1) {
                      window.alert('此用户名已注册');
                      this.username = '';
                      this.password2 = '';
                      this.password = '';
                    }
                  }
                });
              } else {
                window.alert('正确的图片格式');
              }
            } else {
              window.alert('上传一张你的图片');
            }
          } else {
            window.alert('看看是否都输入正确');
          }
        } else {
          window.alert('请不要留空');
        }
      },
      isSame: function () {
        if (this.password && this.password2) {
          if (this.password === this.password2) {
            this.wordError2 = false;
            this.wordSuccess2 = true;
            return '两次密码一样';
          } else {
            this.wordError2 = true;
            this.wordSuccess2 = false;
            return '两次密码不一样，重新输入';
          }
        } else {
          this.wordError2 = false;
          this.wordSuccess2 = false;
        }
      },
      isUser: function () {
        if (this.username) {
          if (!/^[a-zA-Z\d]\w{3,11}[a-zA-Z\d]$/.test(this.username)) {
            this.nameError = true;
            this.nameSuccess = false;
            return '用户名只能由字母,数字,下划线4-12位组成';
          } else {
            this.nameError = false;
            this.nameSuccess = true;
          }
        } else {
          this.nameError = false;
          this.nameSuccess = false;
        }
      },
      isPass() {
        if (this.password) {
          if (!/^[a-zA-Z]\w{5,17}$/.test(this.password)) {
            this.wordError = true;
            this.wordSuccess = false;
            return '密码:以字母开头,长度在6-18之间,只能包含字符,数字和下划线';
          } else {
            this.wordError = false;
            this.wordSuccess = true;
          }
        } else {
          this.wordError = false;
          this.wordSuccess = false;
        }
      },
      // 登录请求
      loginBlog: function () {
        if (this.nameSuccess && this.wordSuccess) {
          this.originalUser = this.username;
          var MD5password = MD5.md5(this.password);
          this.axios.post('/user/login', {username: this.username, password: MD5password}).then((response) => {
            this.islogin = response.data.ok;
            this.getUsname;
            // 这里用localStorage 存储用户名
            window.localStorage.USERNAME = this.originalUser;
            this.$emit('loginBlog', [this.islogin, this.username]);
          }).catch((error) => {
            if (error.response) {
              // The request was made and the server responded with a status code
              // that falls out of the range of 2xx
//                console.log(error.response.data.error);
              this.islogin = false;
              if (error.response.data.error === 1 || error.response.data.error === 2) {
                window.alert('用户名或者密码错误');
                this.password = '';
                this.username = '';
                this.$emit('loginBlog', this.islogin);
              }
            }
          });
        } else {
          if (!this.username || !this.password) {
            this.btnDanger = true;
            window.alert('用户名和密码不为空');
            this.$emit('loginBlog', this.islogin);
          } else {
            window.alert('请正确输入用户名和密码');
            this.$emit('loginBlog', this.islogin);
            this.btnDanger = false;
          }
        }
      }
    }
  };
</script>

<style>
  .form-horizontal{
    margin: 0 auto;
  }
  .labelUser{
    font-size: 17px;
    font-weight: 500;
  }
  .username,.password{
    width:300px;
    height: 40px;
    box-sizing: border-box;
  }
  .password{
    padding-top: 5px;
  }
  .icon-glyphicon-ok{
    padding-right: 20px;
  }
  .loginBut{
    margin-right: 20px;
  }
  .helpText{
    text-align: left;
    margin-left: -15px;
  }
  .bg{
    position: fixed;
    left: 0;
    top:0;
    height: 100%;
    width: 100%;
    background-color: #ddd;
    z-index: 200;
  }
  .reg{
    margin-top: -100px;
    padding-top: 80px;
    width: 750px;
    height: 400px;
    position: relative;
    background-color: #fff;
    z-index: 201;
    box-shadow: 0 5px 15px rgba(0,0,0,.5);
    border-radius: 6px;
  }
  .regBut{
    margin: 20px auto;
    width:86px ;
  }
  .backBtn{
    position: absolute;
    bottom: 10px;
    right: 10px;
  }
  .fade-enter-active,.fade-leave-active{
    transition: all .5s;
  }
  .fade-enter,.fade-leave-to{
    opacity: 0;
  }
  .form-group .avatar{
    display: inline-block;
    width: 180px;
  }
  .form-group .image-help{
    margin: 0 70px 0 0;
  }
  .form-group .avatar-img{
    box-sizing: border-box;
    width: 50px;
    border-radius: 50%;
    margin-left: 20px;
  }
</style>
