// Imports
// Importing core libraries
import 'dart:math';
import 'dart:io';

// Importing libraries from external packages
// import 'package:test/test.dart';

// Importing files
// import 'path/to/my_other_file.dart';

void main() {
  print("Hello World");

  Play();
}

void Play() {
  // Variables
  var name = 'Voyager I';
  var year = 1977;
  var antennaDiameter = 3.7;
  var flybyObject = ['Jupiter', 'Seturn', 'Uranus', 'Neptune'];
  var image = {
    'tags' : ['saturn'],
    'url' : '//path/to/saturn.jpg'
  };

  // Control Flow Statements
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }

  for (var object in flybyObject) {
    print(object);
  }

  for (int month = 1; month <= 12; month++) {
    print(month);
  }

  while (year < 2016) {
    year += 1;
  }

  // Functions
  print(fibonacci(12));
  flybyObject.where((name) => name.contains('tu')).forEach(print);

  // Comments
  // This is a normal, one-line comment.

  /// This is a documentation comment, used to document libraries,
  /// classes, and their members. Tools like IDEs and dartdoc treat
  /// doc comments specially.

  /* Comments like these are also supported. */

  // Classed
  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  voyager.describe();

  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();

  // Inheritance
  var voyager4InOrbiter = Orbiter('Voyager IV', DateTime(2022, 10, 25), 10000);
  voyager4InOrbiter.describe();

  // Async
  printWithDelay('message');
  print('How about main thread');

  createDescriptions({'test1','test2'});
  // How to use report()?

  
  // Exceptions
  var piloted = Piloted();
  if (piloted.astronauts == 0) {
    throw StateError('No astronauts.');
  }
  tryException(['test1','test2']);

}

// Exceptions
Future<void> tryException(List<String> flybyObject) async {
  try {
    for (var object in flybyObject) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (e) {
    print('Could not describe object: $e');
  } finally {
    flybyObject.clear();
  }

}

// Functions
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

//Classes
class Spacecraft {
  String name;
  DateTime launchDate;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  int get launchYear => launchDate?.year; // read-only non-final property

  // Method.
  void describe() {
    print('Spacecraft: $name');
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      if (years >= 0) {
        print('Launched: $launchYear ($years years ago)');
      } else {
        print('Will Launche: $launchYear (${years.abs()} years later)');
      }
    } else {
      print('Unlaunched');
    }
  }

}

// Inheritance
class Orbiter extends Spacecraft {
  num altitude;
  Orbiter(String name, DateTime launchDate, this.altitude) : super(name,launchDate);

  @override
  void describe() {
    super.describe();
    print('Attach $altitude meter');
  }
}

// Mixins
class Piloted {
  int astronauts = 1;
  // int name;
  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft() : super.unlaunched('Empty');
}

// Interfaces and abstract classes
// class MockSpaceship implements Spacecraft {
// }
// Make be comment, avoid constructor error.

abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('======');
    describe();
    print('======');
  }
}

// Async
const oneSecond = Duration(seconds: 1);

Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}
Future<void> printWithDelayOriginal(String message) {
  return Future.delayed(oneSecond).then((_) {
    print(message);
  });
}

Future<void> createDescriptions(Iterable<String> objects) async {
  for (var object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already existe. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (var object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} files by $object';
  }
}
