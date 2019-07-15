import Vue from 'vue'
import EditNotice from '@/components/EditNotice'
import ElementUI from 'element-ui'
Vue.use(ElementUI)

describe('EditNotice.vue', () => {
  
  
    it('标题正确渲染', () => {
        const Constructor = Vue.extend(EditNotice)
        const vm = new Constructor().$mount()
        expect(vm.$el.querySelector('.t').textContent).to.equal('编辑物业通知')
      })
});