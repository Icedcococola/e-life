import Vue from 'vue'
import LaunchedNotice from '@/components/LaunchedNotice'
import ElementUI from 'element-ui';
Vue.use(ElementUI);

var axios = require("axios")
var {
    expect
} = require("chai")

describe('LaunchedNotice.vue', () => {
  it('标题正确渲染', () => {
    const Constructor = Vue.extend(LaunchedNotice)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.titl').textContent).to.equal('物业通知')
  })

  it("物业通知列表接口调用正常", function (done) {
    
    axios.get("http://localhost:8080/Propertynotice/findAll")

        .then(function (res) {
            expect(res.status).to.equal(200)
            done()
        })
  }),

  it("物业通知列表接口返回值正常", function (done) {
    
    axios.get("http://localhost:8080/Propertynotice/findbyid",
    {
      params:{
        propertynoticeid:46518
      }
    })
        .then(function (res) {
            expect(res.data.title).to.be.a('String')
            expect(res.data.time).to.be.a('String')
            done()
        })
  })
})
