
module.exports = {
  scrollToTop: function (scrollDuration) {
    var scrollHeight = window.scrollY;
    var scrollStep = Math.PI / (scrollDuration / 15);
    var cosParameter = scrollHeight / 2;
    var scrollCount = 0;
    var scrollMargin;
    var scrollInterval = setInterval(function() {
      if (window.scrollY !== 0) {
        scrollCount = scrollCount + 1;
        scrollMargin = cosParameter - cosParameter * Math.cos(scrollCount * scrollStep);
        window.scrollTo(0, (scrollHeight - scrollMargin));
      } else {
        clearInterval(scrollInterval);
      };
    }, 15);
  }
};
