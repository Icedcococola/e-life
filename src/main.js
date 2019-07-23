// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import 'element-ui/lib/theme-chalk/base.css';
// collapse 展开折叠
import CollapseTransition from 'element-ui/lib/transitions/collapse-transition';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import Vue from 'vue'
import App from './App'
import router from './router/index'
import store from './store/index'
import axios from 'axios'
import VueAxios from 'vue-axios'
import AMap from 'vue-amap'
import 'babel-polyfill'
import 'lib-flexible'

Vue.config.productionTip = false
Vue.use(ElementUI);
Vue.use(VueAxios,axios)
Vue.use(AMap)
Vue.component(CollapseTransition.name, CollapseTransition)


/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})


AMap.initAMapApiLoader({
  // 高德的key
  key: '7b30a3e68d7d4f8445748a7f78e89eb6',
  // 插件集合 （插件按需引入）
  plugin: ['AMap.Autocomplete', 'AMap.PlaceSearch', 'AMap.Scale', 'AMap.OverView', 'AMap.ToolBar', 'AMap.MapType', 'AMap.PolyEditor', 'AMap.CircleEditor']
});


