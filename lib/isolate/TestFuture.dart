
import 'dart:async';

/// 微任务2比微任务1先执行，这是因为then方法我们可以看做和Future的任务是一个整体，
/// 也就是then方法(一个微任务)先添加进入队列，然后微任务1的微任务会添加到then方法后边，所以then方法先执行；
/// whenComplete也可以看做和Future的任务是一个整体，whenComplete和then会按照添加顺序执行；
///
/// 虽然Future是个异步任务，但是在Future中的耗时操作是会阻塞主线程的
///
/// catchError 与 then(onError) 中的连续调用，当其中一个捕获到异常，则另一个不在获取异常信息
void main(){
  testAsyncAwait4();
  // getData();
  print('main() end');
}
String _string = '默认';
getData() {
  print('开始：$_string');
  Future(() {
    print('开始 Future()');
    for (int i = 0; i < 1000000000; i++) {
      _string = '耗时操作';
    }
    print('结束：$_string');
  });
}

/// async用来表示函数是异步的，定义的函数会返回一个Future对象，可以使用then方法添加回调函数；
/// await后面是一个Future，表示等待该异步任务完成，异步完成后才会继续往下执行；await必须出现在async函数内部；
/// async和await只是一个语法糖，编译器或者解释器最终都会将其转化为一个Future的调用链；
testAsyncAwait() async {
  print('开始：$_string');
  await Future(() {
    for (int i = 0; i < 1000000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
  });

  print('结束：$_string');
}
testAsyncAwait2() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 1000000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    return _string;//必须有返回值才能在then中获取到
  });
  future.then((value) {
    print('then方法: value=$value');
  });
  print('结束：$_string');
}
testAsyncAwait3() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.then((value) {
    print('then方法: value=$value');//不打印
  });
  future.catchError((onError) {//打印，会崩溃，Unhandled exception:
    print('catchError 方法: onError=$onError');
  });
  print('结束：$_string');
}

///此处的onError方法是在then内部定义的，所以需要在then方法内部调用，而非平级；
// catchError是在整个Future的链式调用过程中捕获异常，而onError只在当前then中处理；我们在一个链式调用的过程中可能存在多个then；
testAsyncAwait4() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.then((value) {
    print('then方法: value=$value');//不打印
  //   throw Exception("哈哈哈");//此处的异常无法被捕获
  }).catchError((onError){
    print('catchError 方法: onError=$onError');// 打印【网络异常】，不崩溃
  }).whenComplete(() {//会打印
    print('whenComplete');
    throw Exception("哈哈哈");
  }).catchError((onError){
    print('catchError 方法: onError=$onError');// 打印【哈哈哈】，不崩溃
  });
  print('结束：$_string');
}
testAsyncAwait16() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    // throw Exception('网络异常');
    return 3;
  });
  future.then((value) {
    print('then方法: value=$value');//不打印
  }).whenComplete(() {//会打印
    print('whenComplete');
    throw Exception("哈哈哈");
  }).catchError((onError){
    print('catchError 方法: onError=$onError');// 打印【哈哈哈】，不崩溃
  });
  print('结束：$_string');
}
testAsyncAwait15() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    // throw Exception('网络异常');
    return 3;
  });
  future.then((value) {
    print('then方法: value=$value');//不打印
    throw Exception("哈哈哈");//此处的异常无法被捕获
  }).whenComplete(() {//会打印
    print('whenComplete');
  }).catchError((onError){
    print('catchError 方法: onError=$onError');// 打印【哈哈哈】，崩溃 Invalid argument(s) (onError): The error handler of Future.catchError must return a value of the future's type
  });
  print('结束：$_string');
}

testAsyncAwait14() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.then((value) {
    print('then方法: value=$value');//不打印
    throw Exception("哈哈哈");
  }).whenComplete(() {//会打印
    print('whenComplete');
  }).catchError((onError){
    print('catchError 方法: onError=$onError');// 打印，崩溃【网络异常】
  });
  print('结束：$_string');
}

testAsyncAwait13() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.then((value) {
    print('then方法: value=$value');//不打印
  }, onError: (onError){
    print('then方法: onError=$onError');//打印
  });
  future.whenComplete(() {//会打印，不崩溃
    print('whenComplete');
  }).catchError((onError){
    print('catchError 方法: onError=$onError');// 打印，不崩溃
  });
  print('结束：$_string');
}

testAsyncAwait12() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.then((value) {
    print('then方法: value=$value');//不打印
  }, onError: (onError){
    print('then方法: onError=$onError');//打印
  }).whenComplete(() {//会打印，不崩溃
    print('whenComplete');
  });
  print('结束：$_string');
}
testAsyncAwait11() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.then((value) {
    print('then方法: value=$value');//不打印
  }, onError: (onError){
    print('then方法: onError=$onError');//打印
  });
  future.whenComplete(() {//会打印， 崩溃，Unhandled exception:
    print('whenComplete');
  });
  print('结束：$_string');
}

testAsyncAwait10() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.catchError((onError) {//打印
    print('catchError 方法: onError=$onError');
  }).then((value) {
    print('then方法: value=$value');//打印此处
  }, onError: (onError){
    print('then方法: onError=$onError');//不会打印
  });
  future.whenComplete(() {//会打印， 崩溃，Unhandled exception:
    print('whenComplete');
  });
  print('结束：$_string');
}
///此处的onError方法是在then内部定义的，所以需要在then方法内部调用，而非平级；
// catchError是在整个Future的链式调用过程中捕获异常，而onError只在当前then中处理；我们在一个链式调用的过程中可能存在多个then；
testAsyncAwait9() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.catchError((onError) {//打印，没有崩溃
    print('catchError 方法: onError=$onError');
  }).then((value) {
    print('then方法: value=$value');//打印，不打印 onError的信息
  }, onError: (onError){
    print('then方法: onError=$onError');
  }).then((value) {
    print('then方法: value=$value');//打印，不打印 onError的信息
  }, onError: (onError){
    print('then方法: onError=$onError');
  });
  print('结束：$_string');
}

///此处的onError方法是在then内部定义的，所以需要在then方法内部调用，而非平级；
// catchError是在整个Future的链式调用过程中捕获异常，而onError只在当前then中处理；我们在一个链式调用的过程中可能存在多个then；
testAsyncAwait8() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.catchError((onError) {//打印，没有崩溃
    print('catchError 方法: onError=$onError');
  }).then((value) {
    print('then方法: value=$value');//打印，不打印 onError的信息
  }, onError: (onError){
    print('then方法: onError=$onError');
  });
  print('结束：$_string');
}

testAsyncAwait7() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.then((value) {
    print('then方法: value=$value');
  }, onError: (onError){
    print('then方法: onError=$onError');//打印，没有崩溃，不打印then的信息
  }).catchError((onError) {//不会打印，没有崩溃
    print('catchError 方法: onError=$onError');
  });
  print('结束：$_string');
}

testAsyncAwait6() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.catchError((onError) {//打印，没有崩溃，可以打印then的信息
    print('catchError 方法: onError=$onError');
  }).then((value) {
    print('then方法: value=$value');
  });
  print('结束：$_string');
}

testAsyncAwait5() async {
  print('开始：$_string');
  Future future = Future(() {
    for (int i = 0; i < 100000000; i++) {
      _string = '网络数据';
    }
    print('获取到数据：$_string');
    throw Exception('网络异常');
  });
  future.then((value) {
    print('then方法: value=$value');
  }).catchError((onError) {
    print('catchError 方法: onError=$onError');//打印，不会崩溃，但是无法打印then的信息
  });
  print('结束：$_string');
}


testFuture(){
  Future f = Future(() {
    print('异步任务1');
    scheduleMicrotask(() {
      print('微任务1');
    });
  });
  f.whenComplete(() {
    print('完成');
  });
  f.then((value) {
    print('微任务2');
  });
}
