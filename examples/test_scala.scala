// Scala example file for testing dynamic TSG generation
package example

import scala.collection.mutable.ArrayBuffer
import scala.util.{Try, Success, Failure}

// Case class (immutable data class)
case class Person(name: String, age: Int) {
  // Method
  def greet(): String = s"Hello, my name is $name and I am $age years old."
  
  // Method with default and named parameters
  def haveBirthday(celebrate: Boolean = true): Person = {
    val newPerson = this.copy(age = age + 1)
    if (celebrate) {
      println(s"Happy birthday! Now I am ${newPerson.age} years old.")
    }
    newPerson
  }
}

// Trait (interface)
trait Animal {
  def species: String
  def makeSound(): String
}

// Class implementing a trait
class Dog(val breed: String) extends Animal {
  override def species: String = "Canis familiaris"
  override def makeSound(): String = "Woof!"
  
  // Additional method
  def fetch(item: String): String = s"The $breed fetched the $item!"
}

// Singleton object (static class)
object MathUtils {
  def factorial(n: Int): Int = {
    if (n == 0) 1 else n * factorial(n - 1)
  }
  
  // Higher-order function (takes a function as parameter)
  def processNumbers(numbers: List[Int], processor: Int => Int): List[Int] = {
    numbers.map(processor)
  }
}

// Algebraic data type with pattern matching
sealed trait Result[+A]
case class Success[A](value: A) extends Result[A]
case class Failure(error: String) extends Result[Nothing]

// Function using the algebraic data type
def divide(a: Int, b: Int): Result[Int] = {
  if (b == 0) Failure("Division by zero")
  else Success(a / b)
}

// Main application object
object ScalaExample extends App {
  // Create a Person
  val person = Person("Alice", 30)
  println(person.greet())
  
  // Use the Animal trait
  val dog = new Dog("Golden Retriever")
  println(s"${dog.breed} says ${dog.makeSound()}")
  println(dog.fetch("ball"))
  
  // Use the MathUtils object
  println(s"Factorial of 5: ${MathUtils.factorial(5)}")
  
  // Use the higher-order function
  val numbers = List(1, 2, 3, 4, 5)
  val doubled = MathUtils.processNumbers(numbers, _ * 2)
  println(s"Doubled numbers: $doubled")
  
  // Pattern matching with the Result type
  val result1 = divide(10, 2)
  val result2 = divide(10, 0)
  
  def handleResult(result: Result[Int]): String = result match {
    case Success(value) => s"Result: $value"
    case Failure(error) => s"Error: $error"
  }
  
  println(handleResult(result1))
  println(handleResult(result2))
}