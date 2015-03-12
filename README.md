## 结构

<pre>
|-- src 资源文件夹
|    |-- base 各种基础文件
|    |    |-- js 由于模块化加载，所以js不会合并, 目标地为/build/assets/js；--production模式下会单独压缩;
|    |    |-- css 基础css文件，会自动压缩并合成单独文件 /build/assets/css/base.css;
|    |    |-- fonts 直接复制到 /build/assets/css/fonts；
|    |
|    |-- coffee coffee文件，模块化加载,会自动编译为js,目标地为/build/assets/js； --production模式下会单独压缩;
|    |-- img 直接复制到/build/assets/img；
|    |-- scss 合并为/build/assets/js/app.css; --production模式下会压缩;
|    |-- templates 直接复制到/build/templates；--production模式下会压缩;
|    |-- index.html 主页面文件, 输出到 /build/index.html;--production模式下会压缩;
|
|-- build 运行文件夹，无须直接操作
|    |-- assets 
|    |    |-- js
|    |    |-- css
|    |    |-- fonts
|    |    |-- img
|    |-- templates
|    |-- index.html 
</pre>

## 命令

`gulp` 直接监听build目录并建立服务，服务地址为 [http://127.0.0.1:8888](http://127.0.0.1:8888) ，更新自动刷新页面；

`gulp clean` 删除 build 目录；

`gulp build` 重新生成 build 目录内的文件，但手动加入build目录的文件不会被删除，只替换脚本生成的文件；

`gulp build --production` 在 `gulp build` 的基础上，加入压缩的操作；

## 使用

```
~> git clone https://github.com/shatle/gulp_test
~> cd gulp_test
gulp_test> npm install
gulp_test> gulp
```

在浏览器中打开地址： [http://127.0.0.1:8888](http://127.0.0.1:8888)




