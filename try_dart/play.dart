import 'dart:async';
import 'dart:math';

main(List<String> args) {
  dartClasses();
}

// --Compute Pi-->
void dartComputePi() async { 
  print('Compute π using the Monte Carlo method.');
  await for (var estimate in computePi().take(100)) {
    print('π ≅ $estimate');
  }
}

/// Generates a stream of increasingly accurate estimates of π.
Stream<double> computePi({int batch: 100000}) async* {
  var total = 0;
  var count = 0;
  while(true) {
    var points = generateRandom().take(batch);
    var inside = points.where((p) => p.isInsideUnitCircle);
    total += batch;
    count += inside.length;
    var ratio = count / total;
    // Area of a circle is A = π⋅r², therefore π = A/r².
    // So, when given random points with x ∈ <0,1>,
    // y ∈ <0,1>, the ratio of those inside a unit circle
    // should approach π / 4. Therefore, the value of π
    // should be:
    yield ratio * 4;
  }
}

Iterable<Point> generateRandom([int seed]) sync* {
  final random = Random(seed);
  while(true) {
    yield Point(random.nextDouble(), random.nextDouble());
  }
}

class Point {
  final double x, y;
  const Point(this.x, this.y);
  bool get isInsideUnitCircle => x * y + y * y <= 1;
}
// --Compute Pi--/>


// --Classes-->
void dartClasses() {
  // The 'new' keywork is optional.
  var chest = Chest<Item>([
    DiamondSword(),
    Sword(),
  ]);

  chest.use();

  for (var item in chest.contents) {
    item.use();
  }
}
// Abstract classes can't be instantiated.
abstract class Item {
  use();
}
// Classes can implement other classes.
class Chest<T> implements Item {
  List<T> contents;

  // Constructors can assign arguments to instance variables using `this`.
  Chest(this.contents);

  @override
  use() => print("$this has ${contents.length} items.");
}

class Sword implements Item {
  int damage = 5;

  @override
  use() => print("$this dealt $damage damage.");
}

class DiamondSword extends Sword {
  int damage = 50;
}
// --Classes--/>


// --Collection literals-->
void dartCollectionLiterals() {
  // A list literal.
  var lostNumbers = [4,8,15,16,23,42];

  // A map literal.
  var nobleGases = {
    'He': 'Helium',
    'Ne': 'Neon',
    'Ar': 'Argon',
  };

  // A set literal.
  var frogs = {
    'Tree',
    'Poison dart',
    'Glass',
  };

print(lostNumbers.last);
print(nobleGases['Ne']);
print(frogs.difference({'Poison dart'}));
}
// --Collection literals--/>

// --practice strings-->
void dartStrings() {
  print('a single quoted string');
  print("a double quoted string");
  // Strings can be conbined with the + operator.
  print("cat" + "dog");
  // Triple qutoes define a multi-line string.
  print('''triple quoted strings
#\$&%*&*^^%&
are for miltiple line''');

  // Dart supports string interpolation.
  var pi = 3.14;
  print('pi is $pi'); // single quoted
  print("tau is ${2 * pi}"); // double quoted
}
// --practice strings--/>

// --practice control flow-->
void dartControlFlow() {
  var numbers = List.generate(10, (i) => i*3);
  print(getEvenNumbers(numbers));
}

isEven(int x) {
  if (x % 2 == 0) {
    return true;
  } else {
    return false;
  }
}

List<int> getEvenNumbers(Iterable<int> numbers) {
  var evenNumbers = <int>[];

  for (var i in numbers) {
    if (isEven(i)) evenNumbers.add(i);
  }
  return evenNumbers;
}
// --practice control flow--/>

// --practice function-->
void dartFunction() {
  print("4 times two is ${timesTwo(4)}");
  print("4 times four is ${timesFour(4)}");
  print("2 x 2 x 2 is ${runTwice(2, timesTwo)}");
  runTripple(myPrint);
}

int timesTwo(int x) {
  return x * 2;
}

int timesFour(int x) => timesTwo(timesTwo(x));

int runTwice(int x, Function f) {
  for (var i = 0; i < 2; i++) {
    x = f(x);
  }
  return x;
}

void myPrint(String msg) {
  print(msg);
}
void runTripple(Function f) {
  for (var i = 0; i < 100; i++) {
    f("time $i");
  }
}
// --practice function--/>