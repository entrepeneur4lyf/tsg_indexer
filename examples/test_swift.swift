// Swift example file for testing dynamic TSG generation
import Foundation

// A simple class definition
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func greet() -> String {
        return "Hello, my name is \(name) and I am \(age) years old."
    }
    
    func haveBirthday() {
        age += 1
        print("Happy birthday! Now I am \(age) years old.")
    }
}

// A protocol (interface)
protocol Animal {
    var species: String { get }
    func makeSound() -> String
}

// A struct implementing the protocol
struct Dog: Animal {
    var species: String = "Canis familiaris"
    var breed: String
    
    func makeSound() -> String {
        return "Woof!"
    }
}

// An enum with associated values
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
    
    func unwrap() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

// A function using generics
func processArray<T>(_ array: [T], processor: (T) -> T) -> [T] {
    return array.map(processor)
}

// Main execution
func main() {
    let person = Person(name: "John", age: 30)
    print(person.greet())
    
    let dog = Dog(breed: "Golden Retriever")
    print("\(dog.breed) says \(dog.makeSound())")
    
    let numbers = [1, 2, 3, 4, 5]
    let doubled = processArray(numbers) { $0 * 2 }
    print("Doubled numbers: \(doubled)")
}

main()