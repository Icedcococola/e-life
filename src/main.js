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
import VueAMap from 'vue-amap'
import 'babel-polyfill'
import 'lib-flexible'

Vue.config.productionTip = false
Vue.use(ElementUI);
Vue.use(VueAxios,axios)
Vue.use(VueAMap)
Vue.component(CollapseTransition.name, CollapseTransition)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})


VueAMap.initAMapApiLoader({
  // 高德的key
  key: 'e9a0d9e6f808a90e92c1739b37cc0185',
  // 插件集合 （插件按需引入）
  plugin: ['Autocomplete', 'Scale', 'OverView', 'ToolBar', 'MapType','Geolocation','Geocoder'],
  v: '1.4.4'

});

/*
AMap.initAMapApiLoader({
  // 高德的key
  key: 'e9a0d9e6f808a90e92c1739b37cc0185',
  // 插件集合 （插件按需引入）
  plugin: ['Autocomplete', 'Scale', 'OverView', 'ToolBar', 'MapType', 'PolyEditor','Geocoder'],
  v: '1.4.4'

});

*/