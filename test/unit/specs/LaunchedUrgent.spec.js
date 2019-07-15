
import Vue from 'vue'
import LaunchedUrgent from '@/components/LaunchedUrgent'
import ElementUI from 'element-ui';
Vue.use(ElementUI);


describe('LaunchedUrgent.vue', () => {
  it('标题正确渲染', () => {
    const Constructor = Vue.extend(LaunchedUrgent)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.a').textContent)
      .to.equal('紧急通知')
  })

})
