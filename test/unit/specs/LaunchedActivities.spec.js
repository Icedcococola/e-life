import { destroyVM, createTest } from '../util'
import LaunchedActivities from '@/components/LaunchedActivities'

describe('LaunchedActivities.vue', () => {
  let vm

  afterEach(() => {
    destroyVM(vm)
  })

  it('测试获取元素内容', () => {
    vm = createTest(LaunchedActivities, { content: '活动安排' }, true)
    expect(vm.$el.querySelector('.xx').textContent).to.equal('活动安排')
  })

})