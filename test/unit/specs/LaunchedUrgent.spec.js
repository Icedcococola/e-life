import Vue from 'vue'
import LaunchedUrgent from '@/components/LaunchedUrgent'
import ElementUI from 'element-ui';
Vue.use(ElementUI);

var axios = require("axios")
var {
    expect
} = require("chai")

describe('LaunchedUrgent.vue', () => {
  it('标题正确渲染', () => {
    const Constructor = Vue.extend(LaunchedUrgent)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.a').textContent).to.equal('紧急通知')
  })

  it("紧急同通知列表接口调用正常", function (done) {
    
    axios.get("http://localhost:8080/Emergencynotic/findAll")

        .then(function (res) {
            expect(res.status).to.equal(200)
            done()
        })
  }),

  it("紧急通知列表接口返回值正常", function (done) {
    
    axios.get("http://localhost:8080/Emergencynotic/findbyid",
    {
      params:{
        emergencynoticeid:45132
      }
    })
        .then(function (res) {
            expect(res.data.title).to.be.a('String')
            expect(res.data.time).to.be.a('String')
            done()
        })
  })
})
