function toDou (n) {
  return n < 10 ? '0' + n : '' + n;
}
module.exports = {
  // 得到以秒为单位的时间
  gettime: function () {
    let date = new Date();
    // 后台存储数据以秒存储
    return date.getTime() / 1000;
  },
  // 得到2017-6-5 12：12：12 传递以秒为单位的时间
  timeDate: function (time) {
    var oDate = new Date();
    oDate.setTime(time * 1000);
    return oDate.getFullYear() + '-' + toDou(oDate.getMonth() + 1) + '-' + toDou(oDate.getDate()) + ' ' + toDou(oDate.getHours()) + ':' + toDou(oDate.getMinutes()) + ':' + toDou(oDate.getSeconds());
  },
  // 得到当前完整年，和当前月份
  timeYear: function () {
    let date = new Date();
    return {
      // 当前年份2017
      year: date.getFullYear(),
      // 当前月份
      month: date.getMonth() + 1
    };
  }
};
