<template>
  <div class="article" :style="{position: none,backgroundImage: bgImg}">
     <div class="article-text" v-show="isID">
       <div class="article-text-left">
         <h1>日期{{Years}}</h1>
         <a @click="gotoList(key)" v-for="(value,key) in years">
           <p>{{key}}年 ({{value}})</p>
         </a>
       </div>
       <div class="article-text-right">
         <h1>最近发布的文章</h1>
         <div class="text" v-for="banner in banners">
           <router-link :to="{path:banner.href}">
             <h3>{{banner.title}}</h3>
           </router-link>
           <p>{{banner.description}}...</p>
         </div>
         </div>
     </div>
    <transition name="detail-fade" mode="out-in">
        <router-view></router-view>
    </transition>

  </div>
</template>

<script>
  export default{
    data() {
        return {
            banners: [],
            none: 'fixed',
            bgImg: 'url(../../../../static/article_bg.jpg)',
            years: {}
        };
    },
    created() {
      this.axios.get('/home/article').then((res) => {
            this.banners = res.data;
      }).catch((error) => {
          console.log(error);
        });
    },
    methods: {
        gotoList(key) {
            this.$router.push({path: '/home/' + this.getUsername + '/article' + '/list/' + key});
        }
    },
    computed: {
        Years() {
           for (var i = 0; i < this.banners.length; i++) {
              if (this.years[this.banners[i].year] !== undefined) {
                this.years[this.banners[i].year] += 1;
              } else {
                this.years[this.banners[i].year] = 1;
              }
          }
        },
        isID() {
            if (this.$route.params.id) {
                this.none = '';
                this.bgImg = 'url("")';
                return false;
            } else {
              this.none = 'fixed';
              this.bgImg = 'url(../../../../static/article_bg.jpg)';
              return true;
            }
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
    }
  };
</script>

<style>
  .article{
    width: 100%;
    height: 100%;
    background-color: rgba(255,255,255,0.4);
    /*position: fixed;*/
    top:0;
    /*background-image: url("../../../../static/article_bg.jpg");*/
  }
  .article-text{
    position: absolute;
    display: flex;
    /*width: 1150px;*/
    /*height: 574px;*/
    margin: -277px 0 0 -575px;
    top:50%;
    left: 50%;
  }
  .article-text-left{
    flex: 1;
    width: 520px;
    height: 534px;
    padding: 20px;
    margin-right: 30px;
    overflow: auto;
    background-color: rgba(255,255,255,0.3);
  }
  .article-text-left a{
    display: inline-block;
    width: 124px;
    height: 50px;
    line-height: 50px;
    cursor: pointer;
    background-color: rgba(0,0,0,.7);
  }
  .article-text-left p{
    display: inline-block;
    margin-left: 20px;
    font-size: 16px;
  }
  .article-text-left p:before{
    content: '●';
    margin-right: 10px;
  }
  .article-text-right{
    flex: 1;
    width: 520px;
    height: 534px;
    padding: 20px;
    overflow: auto;
    background-color: rgba(255,255,255,0.3);
  }
  .article-text-right a{
    text-decoration: none;
  }
  .article-text-right p{
    font-size:  16px;
    text-indent: 2em;
  }
  .article-text-right a h3 {
    font-size: 20px;
  }
  .detail-fade-enter-active,.detail-fade-leave-active{
    transition: all .3s;
  }
  .detail-fade-enter,.detail-fade-leave-active{
    opacity: 0;
  }
</style>
