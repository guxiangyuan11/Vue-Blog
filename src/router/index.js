import Vue from 'vue';
import Router from 'vue-router';
// 懒加载 异步加载组件
const home = r => require.ensure([], () => r(require('../components/base/home/home.vue')), 'home');
const image = r => require.ensure([], () => r(require('../components/base/image/image.vue')), 'image');
const Reason = r => require.ensure([], () => r(require('../components/base/Reason/Reason.vue')), 'Reason');
const article = r => require.ensure([], () => r(require('../components/base/article/article.vue')), 'article');
const detail = r => require.ensure([], () => r(require('../components/base/detail/detail.vue')), 'detail');
const list = r => require.ensure([], () => r(require('../components/base/list/list.vue')), 'list');
const editor = r => require.ensure([], () => r(require('../components/base/editor/editor.vue')), 'editor');
const ErrorHtml = r => require.ensure([], () => r(require('../components/base/404/404.vue')), 'ErrorHtml');
Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '*',
      component: ErrorHtml
    },
    {
      path: '/home/:username',
      component: home,
      children: [
        {
          path: 'article',
          component: article,
          children: [
            {
              path: 'detail/:id',
              component: detail
            },
            {
              path: 'list/:id',
              component: list
            }
          ]
        },
        {
          path: 'Reason',
          component: Reason
        },
        {
          path: 'image',
          component: image
        },
        {
          path: 'editor/:id',
          component: editor
        }
      ]
    }
  ]
});
