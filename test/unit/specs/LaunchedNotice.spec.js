
import Vue from 'vue'
import LaunchedNotice from '@/components/LaunchedNotice'
import ElementUI from 'element-ui';
Vue.use(ElementUI);


describe('LaunchedNotice.vue', () => {
  it('标题正确渲染', () => {
    const Constructor = Vue.extend(LaunchedNotice)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.titl').textContent)
      .to.equal('物业通知')
  })

})
