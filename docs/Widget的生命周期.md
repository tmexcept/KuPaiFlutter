//[生命周期](https://juejin.cn/post/6844903951058354190)
那么StatefulWidget有哪些生命周期的回调呢？它们分别在什么情况下执行呢？
在下图中，灰色部分的内容是Flutter内部操作的，我们并不需要手动去设置它们；白色部分表示我们可以去监听到或者可以手动调用的方法；
我们知道StatefulWidget本身由两个类组成的：StatefulWidget和State，我们分开进行分析
![img.png](docs/img/widgetLifecircle.png)
首先，执行StatefulWidget中相关的方法：
* 执行StatefulWidget的构造函数（Constructor）来创建出StatefulWidget；
* 执行StatefulWidget的createState方法，来创建一个维护StatefulWidget的State对象；
其次，调用createState创建State对象时，执行State类的相关方法：
1、执行State类的构造方法（Constructor）来创建State对象；
2、执行initState，我们通常会在这个方法中执行一些数据初始化的操作，或者也可能会发送网络请求；
3、执行didChangeDependencies方法，这个方法在两种情况下会调用
  * 情况一：调用initState会调用；
  * 情况二：从其他对象中依赖一些数据发生改变时，比如前面我们提到的InheritedWidget（这个后面会讲到）；
4、Flutter执行build方法，来看一下我们当前的Widget需要渲染哪些Widget；
5、当前的Widget不再使用时，会调用dispose进行销毁；
6、手动调用setState方法，会根据最新的状态（数据）来重新调用build方法，构建对应的Widgets；
7、执行didUpdateWidget方法是在当父Widget触发重建（rebuild）时，系统会调用didUpdateWidget方法；
