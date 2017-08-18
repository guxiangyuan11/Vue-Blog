<template>
  <div class="image">
    <div class="image-images">
       <ul>
         <li v-for="(image,index) in images"><img :src=image.url  @click.stop.prevent = 'bounced(index)' alt="" class="img-thumbnail"></li>
       </ul>
    </div>
    <transition name="image-fade">
      <div class="big-image" @click = 'hid = !hid' v-show="hid">
        <div class="big-image-box">
          <img :src="images[index].url" alt="">
        </div>
      </div>
    </transition>

  </div>
</template>

<script>
  export default{
      data () {
          return {
              username: this.$store.state.username,
              hid: false,
              index: 0,
              images: [
                {url: '../../../../static/1.jpg'},
                {url: '../../../../static/2.jpg'},
                {url: '../../../../static/3.jpg'},
                {url: '../../../../static/4.jpg'},
                {url: '../../../../static/5.jpg'},
                {url: '../../../../static/6.jpg'}
              ]
          };
      },
    methods: {
      bounced(index) {
        this.hid = !this.hid;
        this.index = index;
      }
    }
  };
</script>

<style scoped>
  .image{
    position: fixed;
    width: 100%;
    height: 100%;
    top:0;
    background-image: url("1_bg.jpg");
  }
  .image .image-images{
    position: absolute;
    width: 1000px;
    height: 460px;
    margin: -230px 0 0 -500px;
    top: 50%;
    left: 50%;

  }
  .image .image-images ul{
    width: 100%;
    height: 100%;
    padding-left: 0;
  }
  .image .image-images ul li{
    list-style: none;
    float: left;
    margin: 0 20px 20px 0;
  }
  .image .image-images ul li:nth-child(3){
    margin-right: 0;
  }
  .image .image-images ul li:nth-child(6){
    margin-right: 0;
  }
  .image .image-images img{
    width: 320px;
    height: 220px;
    box-sizing: border-box;
  }
  .big-image{
    position: fixed;
    width: 100%;
    height: 100%;
    top:0;
    z-index: 1002;
    background-color: rgba(83,83,98,0.5);
  }
  .big-image .big-image-box{
    position: absolute;

  }
  .image-fade-enter-active,.image-fade-leave-active{
    transition: all .3s ;
  }
  .image-fade-enter,.image-fade-leave-to{
    opacity: 0;
  }
</style>
