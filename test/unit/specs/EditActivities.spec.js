import Vue from 'vue'
import EditActivities from '@/components/EditActivities'
import ElementUI from 'element-ui'
Vue.use(ElementUI)

describe('EditActivities.vue', () => {
  
  
    it('标题正确渲染', () => {
        const Constructor = Vue.extend(EditActivities)
        const vm = new Constructor().$mount()
        expect(vm.$el.querySelector('.t').textContent).to.equal('编辑活动安排')
      })
});