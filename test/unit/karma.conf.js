// This is a karma config file. For more details see
//   http://karma-runner.github.io/0.13/config/configuration-file.html
// we are also using it with karma-webpack
//   https://github.com/webpack/karma-webpack

var webpackConfig = require('../../build/webpack.test.conf')

module.exports = function karmaConfig (config) {
  config.set({
    // to run in additional browsers:
    // 1. install corresponding karma launcher
    //    http://karma-runner.github.io/0.13/config/browsers.html
    // 2. add it to the `browsers` array below.
    //browsers: ['PhantomJS'],
    browsers: ['Chrome'],
    frameworks: ['mocha', 'sinon-chai'],
    reporters: ['spec', 'coverage'],
    files: ['./index.js'],
    preprocessors: {
      './index.js': ['webpack', 'sourcemap','coverage']
    },
    webpack: webpackConfig,
    webpackMiddleware: {
      noInfo: true
    },
    coverageReporter: {
      dir: './coverage',
      reporters: [
        { type: 'lcov', subdir: '.' },
       { type: 'text-summary' }
      ]
    }

    //coverageIstanbulReporter: {
      // 以什么格式, 这里设置了输出 html文件 ,info文件 ,及控制台
    //  reports: ['html', 'lcovonly', 'text-summary'],
      // 将文件输出路径定位
    //  dir: path.join(__dirname, 'coverage'),
      // 修正 weback 路径（翻译了是这个意思）
    //  fixWebpackSourcePaths: true,
      // 将生成的html放到./coverage/html/下
    //  'report-config': {
    //      html: {
    //          subdir: 'html'
    //      }
    //  }
    //}
  })
}
