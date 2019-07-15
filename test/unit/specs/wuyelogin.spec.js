import Vue from 'vue'
import wuyelogin from '@/components/wuyelogin'
import ElementUI from 'element-ui'
Vue.use(ElementUI)

describe('wuyelogin.vue', () => {
  
  
    it('标题正确渲染', () => {
        const Constructor = Vue.extend(wuyelogin)
        const vm = new Constructor().$mount()
        expect(vm.$el.querySelector('.qwer').textContent).to.equal('物业管理员登录')
      })
});