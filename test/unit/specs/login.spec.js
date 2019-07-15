import Vue from 'vue'
import login from '@/components/login'
import ElementUI from 'element-ui';
Vue.use(ElementUI);


describe('login.vue', () => {
  it('物业选项文字是否正确渲染', () => {
    const Constructor1 = Vue.extend(login)
    const vm1 = new Constructor1().$mount()
    expect(vm1.$el.querySelector('.x span').textContent)
      .to.equal('我是物业管理员')

  })

  it('邮包选项文字是否正确渲染',() => {
    const Constructor2 = Vue.extend(login)
    const vm2 = new Constructor2().$mount()
    expect(vm2.$el.querySelector('.y span').textContent)
      .to.equal('我是邮包管理员')

  })
})
