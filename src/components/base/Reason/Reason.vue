<template>
  <div class="reason">
    <div class="reason-words">
      <transition name="reason-left">
      <div class="left animated fadeInRight">
          <h1 >自省</h1>
        <ul>
          <li>吾日三省吾身</li>
          <li>温故而知新</li>
          <li>业精于勤</li>
          <li>任重而道远</li>
          <li>种一棵树最好的时间是十年前，其次是现在</li>
          <li>不愤不启，不悱不发。举一隅而不以三隅反，则不复也</li>
        </ul>
      </div>
      </transition>
      <div class="right animated fadeInRight">
        <transition name="reason-right">
          <h1>自嘲</h1>
        </transition>
        <ul>
          <li>曾经梦想仗剑走天涯，后来作业太多就没去</li>
          <li>我身在江湖,江湖却没有关于我的传说</li>
          <li>人的生命就像在拉屎,我觉的我已经很努力了，可出来的却只是一个屁....</li>
          <li>人生就像打电话，不是你先挂，就是我先挂</li>
          <li>理想就像内裤，要有，但不能逢人就证明你有</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
</script>

<style>
  .reason{
    position: fixed;
    top:0;
    width: 100%;
    height: 100%;
    background: url('2_bg.jpg') no-repeat;
  }
  .reason-words{
    position: absolute;
    display: flex;
    width: 840px;
    height: 500px;
    margin-top: -204px;
    margin-left: -400px;
    top:50%;
    left: 50%;
    padding: 30px;
    background-color: rgba(255,255,255,0.3);
  }
  .reason-words .left,.reason-words .right{
    font-size: 20px;
  }
  .reason-words .left{
       flex:1;
    padding-right: 50px;
    -webkit-animation-duration:1s;
    -webkit-animation-delay:.2s;
    -webkit-animation-iteration-count: 1;
  }
  .reason-words .left li {
    margin-top: 10px;
  }
  .reason-words .right li {
    margin-top: 10px;
  }
  .reason-words .right{
    flex:1;
    -webkit-animation-duration:1.3s;
    -webkit-animation-delay:.3s;
    -webkit-animation-iteration-count: 1;
  }
  .reason-left-enter-active,.reason-left-leave-active{
    transition: all 5s;
  }
  .reason-left-enter,.reason-left-leave-to{
    transform: translateX(100%);
    opacity:0;
  }
</style>
