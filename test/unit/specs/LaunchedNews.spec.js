import Vue from 'vue'
import LaunchedNews from '@/components/LaunchedNews'
import ElementUI from 'element-ui';
Vue.use(ElementUI);

var axios = require("axios")
var {
    expect
} = require("chai")

describe('LaunchedNews.vue', () => {
  it('标题正确渲染', () => {
    const Constructor = Vue.extend(LaunchedNews)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.new').textContent).to.equal('最新资讯')
  })

  it("最新资讯列表接口调用正常", function (done) {
    
    axios.get("http://localhost:8080/Latestnews/findAll")

        .then(function (res) {
            expect(res.status).to.equal(200)
            done()
        })
  }),

  it("最新资讯列表接口返回值正常", function (done) {
    
    axios.get("http://localhost:8080/Latestnews/findbyid",
    {
      params:{
        latestnewsid:9867
      }
    })
        .then(function (res) {
            expect(res.data.title).to.be.a('String')
            expect(res.data.time).to.be.a('String')
            done()
        })
  })
})
