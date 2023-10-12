
import 'dart:io';
import 'dart:isolate';

void main(){
  testIsolate1();
  var a = 'bbb';
  var b = 'bb'+'b';
  print("a==b is ${a == b}");//true
}

/// 打印结果是1、2、3；很明显，即使我们阻塞了主线程，Future里边的任务依然没有先执行；
/// 那么有没有办法能够在主线程阻塞的时候，让3先打印出来呢？这个时候就需要用到Flutter中的多线程操作Isolate了；
void testIsolate() {
  print('1');
  Future(() => print('3'));
  sleep(const Duration(seconds: 2));
  print('2');
}

/// 结果是1 3 2  可以看到，我们阻塞了主线程，即使2没有第一时间打印出来，但是不影响3的输出，
/// 也就是Isolate没有因为主线程的阻塞，而延后调用；那么Isolate是否实在子线程呢？
void testIsolate1() {
  print('1');
  Isolate.spawn(func, 10);
  // sleep(const Duration(seconds: 2));
  print('2');
}
func (int count) => print('3');

/// 打印顺序不再是固定的了，变成了随机的，证明了Isolate确实是在子线程
void testIsolate2() {
  print('1');
  Isolate.spawn(func21, 10);
  Isolate.spawn(func22, 10);
  Isolate.spawn(func21, 10);
  Isolate.spawn(func22, 10);
  Isolate.spawn(func21, 10);
  Isolate.spawn(func22, 10);
  sleep(const Duration(seconds: 2));
  print('2');
}
func21 (int count) {
  print('第一个');
}
func22 (int count) {
  print('第二个');
}

/// Isolate的独立内存空间
// 需要注意的是，Dart中的多线程不仅仅是开辟了一条’线程‘，此处的Isolate与其说是线程，不如说他更像一个进程，
// 因为Isolate有独立的内存空间(主要是自己创建的对象/数据)；
// 这就意味着，每一个Isolate之间的数据是独立的，不会存在资源抢夺的问题，也就不需要使用锁进行操作，
// 那么我们访问数据的时候，也就不能直接访问
void testIsolate3() {
  print('1');
  Isolate.spawn(func3, 100);
  sleep(const Duration(seconds: 2));
  print('a = $a');//10
  print('2');
}
int a = 10;
func3 (int count) {
  a = count;
  print('func 中 a: $a');
}
// 获取Isolate中被修改的数据  此时我们可以监听到a被修改了；
// 在这个过程中，我们做了四件事：
//
// 创建一个接口：ReceivePort;
// 创建一个Isolate;
// 使用创建的ReceivePort来监听数据的变化;
// 在Isolate关联的方法中使用SendPort发送消息进行传值；
//
// 通过以上四步操作，我们可以修改Isolate内部的数据，并获取到新值；
// 但是需要注意的是，我们使用这种方式开监听数据的时候，相当于开辟了空间，那么就需要我们自己来管理销毁
Future<void> testIsolate4() async {
  print('testIsolate4 1');
  // 创建一个接口port
  ReceivePort port = ReceivePort();
  // 创建一个Isolate
  Isolate isolate = await Isolate.spawn(func4, port.sendPort);
  // 通过port监听数据的变化
  port.listen((message) {
    a = message;
    /// 此处会等到主线程执行结束才会执行
    print('port中监听到 a = $a');
    // 关闭port
    port.close();
    // 销毁 isolate
    isolate.kill();
  });
  print('testIsolate4 11');
  //
  // sleep(const Duration(seconds: 2));
  print('a = $a');
  print('2');
}
func4 (SendPort sendPort) {
  sleep(const Duration(seconds: 2));//此处的sleep只影响 isolate线程
  sendPort.send(100);
  print('func 中 a: $a');
}
