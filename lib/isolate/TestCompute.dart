
// compute，它是对Isolate的封装
import 'dart:io';

import 'package:flutter/foundation.dart';//有此导入无法直接运行，必须选择一个device

void main(){
  testCompute();
}

// 先执行1 和func(), 等待2秒打印2
void testCompute() async {
  print("1");

  compute(func, 20);
  sleep(const Duration(seconds: 2));
  print("2");
}
void func (int count) {
  print('func 中count: $count');
}

/// compute和Isolate是有区别的，compute可以接收任务func中的返回值
/// compute的await会引起和Future中同样的等待效果
void testCompute2() async {
  print("1");

  int i = await compute(func2, 20);
  print('compute返回 i= $i');
  print("2");
}
int func2 (int count) {
  sleep(const Duration(seconds: 2));
  print('func 中count: $count');
  return count;
}