/* eslint-disable eqeqeq */
module.exports = {
  setCookie: function (name, value, expiredays) {
  var exdate = new Date();
  exdate.setDate(exdate.getDate() + expiredays);
  document.cookie = name + '=' + encodeURI(value) + ((expiredays == null) ? '' : ';expires=' + exdate.toGMTString());
 },
  getCookie: function(name) {
  var data = document.cookie;
  var dataArray = data.split('; ');
  for (var i = 0; i < dataArray.length; i++) {
    var varName = dataArray[i].split('=');
    if (varName[0] == name) {
      return decodeURI(varName[1]);
    }
  };
 },
  delAllCookie: function () {
  var exdate = new Date();
  exdate.setTime(exdate.getTime() - 1); // 设置时间
  var data = document.cookie;
  var dataArray = data.split('; ');
  for (var i = 0; i < dataArray.length; i++) {
    var varName = dataArray[i].split('=');
    document.cookie = varName[0] + "=''; expires=" + exdate.toGMTString() + '; path=/';
  }
 },
  delCookie: function (name) {
  var exdate = new Date();
    exdate.setTime(exdate.getTime() - 1); // 设置时间
  document.cookie = name + "=''; expires=" + exdate.toGMTString() + '; path=/';
 }
};
