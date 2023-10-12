
void foo() {} // A top-level function

class A {
  static void bar() {} // A static method
  void baz() {} // An instance method
}

void main() {
  Function x;

  // Comparing top-level functions.
  x = foo;
  print(foo == x);

  // Comparing static methods.
  x = A.bar;
  print(A.bar == x);

  // Comparing instance methods.
  var v = A(); // Instance #1 of A
  var w = A(); // Instance #2 of A
  var y = w;
  x = w.baz;

  // These closures refer to the same instance (#2),
  // so they're equal.
  print(y.baz == x);

  // These closures refer to different instances,
  // so they're unequal.
  print(v.baz != w.baz);

  var constantList = [1, 2, 3];
  constantList[1] = 1;
  print(constantList);//[1, 1, 3]
  constantList = const [1, 2, 3];
  // constantList[1] = 1; // This line will cause an error. Unsupported operation: Cannot modify an unmodifiable list

  var names = <String>{};//声明为Set，必须标注参数类型才会推到为Set
  Set<String> names2 = {}; // This works, too.
// var names = {}; // Creates a map, not a set.

  var gifts = {'first': 'partridge'};
  gifts['fourth'] = 'calling birds'; // Add a key-value pair
  final constantMap = const {
    2: 'helium',
    10: 'neon',
    18: 'argon',
  };
// constantMap[2] = 'Helium'; // This line will cause an error.

  // For example, you can use the spread operator (...) to insert all the values of a list into another list:
  var list = [1, 2, 3];
  var list2 = [0, ...list];
  print(list2.length == 4);//true
  //f the expression to the right of the spread operator might be null, you can avoid exceptions by using a null-aware spread operator (...?):

  var list11;
  var list3 = [0, ...?list11];
  print(list3.length == 1);//true
}