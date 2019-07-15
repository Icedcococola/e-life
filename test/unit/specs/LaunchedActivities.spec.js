import Vue from 'vue'
import LaunchedActivities from '@/components/LaunchedActivities'
import ElementUI from 'element-ui';
Vue.use(ElementUI);

var axios = require("axios")
// var app = require("./index.js")
var {
    expect
} = require("chai")

describe('LaunchedActivities.vue', () => {
  it('标题正确渲染', () => {
    const Constructor = Vue.extend(LaunchedActivities)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.tit').textContent)
      .to.equal('活动安排')
  })

  it("活动安排列表接口返回正常", function (done) {
    
    axios.get("http://localhost:8080/Activity/findAll")

        .then(function (res) {
            expect(res.status).to.equal(200)
            done()
        })
  }),

  it("活动安排列表接口返回类型为JSON", function (done) {
    
    axios.get("http://localhost:8080/Activity/findAll")

        .then(function (res) {
            setTimeout(expect(res.data).to.be.a('JSON'),10000)
            done()
        })
  })

})
