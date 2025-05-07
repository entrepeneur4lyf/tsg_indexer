// Dart example file for testing dynamic TSG generation
import 'dart:math';
import 'dart:convert';

// Class definition
class Person {
  final String name;
  int age;
  
  // Constructor
  Person(this.name, this.age);
  
  // Named constructor
  Person.guest() : name = 'Guest', age = 18;
  
  // Method
  String greet() {
    return 'Hello, my name is $name and I am $age years old.';
  }
  
  // Method with optional parameters
  void haveBirthday({bool celebrate = true}) {
    age++;
    if (celebrate) {
      print('Happy birthday! Now I am $age years old.');
    }
  }
  
  // Override toString
  @override
  String toString() {
    return 'Person($name, $age)';
  }
}

// Interface (abstract class)
abstract class Animal {
  String get species;
  String makeSound();
}

// Class implementing an interface
class Dog implements Animal {
  final String breed;
  
  Dog(this.breed);
  
  @override
  String get species => 'Canis familiaris';
  
  @override
  String makeSound() {
    return 'Woof!';
  }
}

// Enum
enum Color { red, green, blue, yellow }

// Extension method
extension ColorExtension on Color {
  String get name {
    return toString().split('.').last;
  }
}

// Generic class
class Box<T> {
  final T value;
  
  Box(this.value);
  
  T getValue() => value;
}

// Function with type parameters
T first<T>(List<T> items) {
  if (items.isEmpty) {
    throw Exception('Empty list');
  }
  return items.first;
}

// Future (async) function
Future<String> fetchData() async {
  // Simulate network delay
  await Future.delayed(Duration(seconds: 1));
  return 'Data loaded';
}

// Main function
void main() async {
  // Create a Person
  final person = Person('John', 30);
  print(person.greet());
  
  // Use the Animal interface
  final dog = Dog('Golden Retriever');
  print('${dog.breed} says ${dog.makeSound()}');
  
  // Use the enum with extension
  final color = Color.blue;
  print('Selected color: ${color.name}');
  
  // Use the generic class
  final box = Box<int>(42);
  print('Box contains: ${box.getValue()}');
  
  // Async function call
  print('Loading data...');
  final data = await fetchData();
  print(data);
}