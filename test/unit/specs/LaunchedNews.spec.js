
import Vue from 'vue'
import LaunchedNews from '@/components/LaunchedNews'
import ElementUI from 'element-ui';
Vue.use(ElementUI);


describe('LaunchedNews.vue', () => {
  it('标题正确渲染', () => {
    const Constructor = Vue.extend(LaunchedNews)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.new').textContent)
      .to.equal('最新资讯')
  })

})
