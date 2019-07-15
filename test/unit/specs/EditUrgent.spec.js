import Vue from 'vue'
import EditUrgent from '@/components/EditUrgent'
import ElementUI from 'element-ui'
Vue.use(ElementUI)

describe('EditUrgent.vue', () => {
  
  
    it('标题正确渲染', () => {
        const Constructor = Vue.extend(EditUrgent)
        const vm = new Constructor().$mount()
        expect(vm.$el.querySelector('.t').textContent).to.equal('编辑紧急通知')
      })
});