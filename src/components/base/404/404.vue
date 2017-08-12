<template>
  <div class="errorback">
    <span class="err404">404</span>
    <ul>
      <li></li>
      <li><span></span></li>
      <li><span></span></li>
      <li><span><span></span></span></li>
      <li><span></span></li>
      <li><span></span></li>
      <li><span><span></span></span></li>
      <li><span></span></li>
    </ul>
  </div>
</template>

<script>
  export default{};
</script>

<style>
.errorback{
  text-align: center;
  width: 100%;
  height: 100%;
  background:#080e24 url("./bg.jpg") repeat;
}
.errorback .err404 {
  position: relative;
  top:50px;
  font-weight: 900;
  font-size: 180px;
  color: rgba(255,255,255,0.7);
  text-shadow: 15px 0 5px #C90;
}
.errorback ul{
  width: 600px;
  height: 695px;
  margin: 0px auto 0;
  position: relative;
  list-style: none;
}
.errorback ul li {
  border: 2px solid #394057;
  position: absolute;
  left: 50%;
  top: 50%;
  border-radius: 50%;
  transform: translate(-50%, -50%);
  box-sizing: border-box;
  animation-iteration-count: infinite;
  animation-timing-function: linear;
  animation-name: orbit;
}
.errorback ul li span{
  display: block;
  position: absolute;
  left: 0;
  width: 12px;
  height: 12px;
  border-radius: 50%;
}
.errorback ul li:nth-child(1) {
  width: 60px;
  height: 60px;
  border: none;
  background-color: #C90;
  box-shadow: 0 0 50px #c90;
  animation-duration: 5s;
}
.errorback ul li:nth-child(2){
  width: 120px;
  height: 120px;
  animation-duration: 6s;
}
.errorback ul li:nth-child(2) span{
  background-color: yellow;
  left: 80px;
  top: 0;
}
.errorback ul li:nth-child(3){
  width: 180px;
  height: 180px;
  animation-duration: 10s;
}
.errorback ul li:nth-child(3) span{
  background-color: blue;
  top:0;
  left: 47px;
}
.errorback ul li:nth-child(4){
  width: 240px;
  height: 240px;
  animation-duration: 12s;
}
.errorback ul li:nth-child(4)>span{
  background-color: green;
  left: 209px;
  top: 43px;
  animation: orbit 2s infinite linear;
}
.errorback ul li:nth-child(4)>span>span{
  width: 6px;
  height: 6px;
  left: 16px;
  background-color: yellow;
}
.errorback ul li:nth-child(5){
  width: 300px;
  height: 300px;
  background-image: url(./asteroids_meteorids.png);
  background-size: cover;
  animation-duration: 25s;
}
.errorback ul li:nth-child(5) span{
  background-color: red;
  left: 95px;
  top: 0;
}
.errorback ul li:nth-child(6){
  width: 360px;
  height: 360px;
  animation-duration: 20s;
}
.errorback ul li:nth-child(6) span{
  background-color: #CCC;
  left: -5px;
  top: 200px;
}
.errorback ul li:nth-child(7){
  width: 420px;
  height: 420px;
  animation-duration: 30s;
}
.errorback ul li:nth-child(7)>span{
  background-color: green;
  left: 300px;
  top: 18px;
}
.errorback ul li:nth-child(7)>span>span{
  width: 20px;
  height: 20px;
  border: 2px solid #CCC;
  left: -4px;
  top: -4px;
  transform: skew(0, 45deg);
}
.errorback ul li:nth-child(8){
  width: 480px;
  height: 480px;
  animation-duration: 35s;
}
.errorback ul li:nth-child(8)>span{
  background-color: pink;
  left: 0;
  top: 170px;
}
@keyframes orbit {
  0% {
    transform: translate(-50%, -50%) rotate(0deg);
  }
  100% {
    transform: translate(-50%, -50%) rotate(360deg);
  }
}
</style>
