// 密码加密包
const crypto = require('crypto');

module.exports = {
    MD5_SUFFIX: 'OQMNAOHOINaskd@##*&$khjnaknduahdan#@',
    md5: function(str) {
        var obj = crypto.createHash('md5');
        obj.update(str + this.MD5_SUFFIX);
        // 以十六进制返回md5加密数据
        return obj.digest('hex');
    }
};
