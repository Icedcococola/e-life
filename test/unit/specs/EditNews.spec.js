import Vue from 'vue'
import EditNews from '@/components/EditNews'
import ElementUI from 'element-ui'
Vue.use(ElementUI)

describe('EditNews.vue', () => {
  
  
    it('标题正确渲染', () => {
        const Constructor = Vue.extend(EditNews)
        const vm = new Constructor().$mount()
        expect(vm.$el.querySelector('.t').textContent).to.equal('编辑最新资讯')
      })
});