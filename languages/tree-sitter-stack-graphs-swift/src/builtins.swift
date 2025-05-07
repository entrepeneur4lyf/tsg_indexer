// This file contains minimal definitions of Swift standard library types
// for use with tree-sitter-stack-graphs.

// Basic integer types
public struct Int: SignedInteger, Comparable, Equatable, Hashable {
    public init()
    public init(_ value: Int)
    public init(_ value: Double)
    public init?(_ string: String, radix: Int = 10)
    
    public static var min: Int
    public static var max: Int
    
    public var bitWidth: Int
    
    public func distance(to other: Int) -> Int
    public func advanced(by n: Int) -> Int
    
    public static func + (lhs: Int, rhs: Int) -> Int
    public static func - (lhs: Int, rhs: Int) -> Int
    public static func * (lhs: Int, rhs: Int) -> Int
    public static func / (lhs: Int, rhs: Int) -> Int
    public static func % (lhs: Int, rhs: Int) -> Int
    
    public static func < (lhs: Int, rhs: Int) -> Bool
    public static func > (lhs: Int, rhs: Int) -> Bool
    public static func <= (lhs: Int, rhs: Int) -> Bool
    public static func >= (lhs: Int, rhs: Int) -> Bool
    public static func == (lhs: Int, rhs: Int) -> Bool
    
    public var hashValue: Int
}

// Floating-point types
public struct Double: FloatingPoint, Comparable, Equatable, Hashable {
    public init()
    public init(_ value: Int)
    public init(_ value: Double)
    public init?(_ string: String)
    
    public static var infinity: Double
    public static var nan: Double
    public static var pi: Double
    
    public var isNaN: Bool
    public var isInfinite: Bool
    public var isFinite: Bool
    public var isZero: Bool
    public var sign: FloatingPointSign
    
    public static func + (lhs: Double, rhs: Double) -> Double
    public static func - (lhs: Double, rhs: Double) -> Double
    public static func * (lhs: Double, rhs: Double) -> Double
    public static func / (lhs: Double, rhs: Double) -> Double
    
    public static func < (lhs: Double, rhs: Double) -> Bool
    public static func > (lhs: Double, rhs: Double) -> Bool
    public static func <= (lhs: Double, rhs: Double) -> Bool
    public static func >= (lhs: Double, rhs: Double) -> Bool
    public static func == (lhs: Double, rhs: Double) -> Bool
    
    public var hashValue: Int
}

// Boolean type
public struct Bool: Equatable, Hashable {
    public init()
    public init(_ value: Bool)
    
    public static var true: Bool
    public static var false: Bool
    
    public static func && (lhs: Bool, rhs: @autoclosure () -> Bool) -> Bool
    public static func || (lhs: Bool, rhs: @autoclosure () -> Bool) -> Bool
    public static prefix func ! (value: Bool) -> Bool
    
    public static func == (lhs: Bool, rhs: Bool) -> Bool
    
    public var hashValue: Int
}

// String type
public struct String: Sequence, Comparable, Equatable, Hashable, ExpressibleByStringLiteral {
    public init()
    public init(_ string: String)
    public init(_ value: Int)
    public init(_ value: Double)
    
    public var count: Int
    public var isEmpty: Bool
    public var startIndex: String.Index
    public var endIndex: String.Index
    
    public func index(after i: String.Index) -> String.Index
    public func index(before i: String.Index) -> String.Index
    
    public subscript(i: String.Index) -> Character
    public subscript(range: Range<String.Index>) -> String
    
    public func hasPrefix(_ prefix: String) -> Bool
    public func hasSuffix(_ suffix: String) -> Bool
    public func contains(_ string: String) -> Bool
    
    public func lowercased() -> String
    public func uppercased() -> String
    public func capitalized() -> String
    
    public func split(separator: Character) -> [String]
    public func components(separatedBy: String) -> [String]
    
    public static func + (lhs: String, rhs: String) -> String
    
    public static func < (lhs: String, rhs: String) -> Bool
    public static func > (lhs: String, rhs: String) -> Bool
    public static func <= (lhs: String, rhs: String) -> Bool
    public static func >= (lhs: String, rhs: String) -> Bool
    public static func == (lhs: String, rhs: String) -> Bool
    
    public var hashValue: Int
}

// Array type
public struct Array<Element>: Sequence, Collection, RandomAccessCollection, MutableCollection, 
                              RangeReplaceableCollection, ExpressibleByArrayLiteral {
    public init()
    public init(repeating: Element, count: Int)
    public init<S: Sequence>(_ sequence: S) where S.Element == Element
    
    public var count: Int
    public var isEmpty: Bool
    public var capacity: Int
    public var startIndex: Int
    public var endIndex: Int
    
    public func index(after i: Int) -> Int
    public subscript(index: Int) -> Element
    public subscript(range: Range<Int>) -> ArraySlice<Element>
    
    public mutating func append(_ newElement: Element)
    public mutating func append<S: Sequence>(contentsOf newElements: S) where S.Element == Element
    
    public mutating func insert(_ newElement: Element, at index: Int)
    public mutating func remove(at index: Int) -> Element
    public mutating func removeFirst() -> Element
    public mutating func removeLast() -> Element
    
    public mutating func removeAll(keepingCapacity: Bool = false)
    
    public func map<T>(_ transform: (Element) -> T) -> [T]
    public func flatMap<T>(_ transform: (Element) -> [T]) -> [T]
    public func filter(_ isIncluded: (Element) -> Bool) -> [Element]
    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result
    
    public func sorted() -> [Element] where Element: Comparable
    public func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element]
    
    public mutating func sort() where Element: Comparable
    public mutating func sort(by areInIncreasingOrder: (Element, Element) -> Bool)
    
    public func contains(_ element: Element) -> Bool where Element: Equatable
    public func contains(where predicate: (Element) -> Bool) -> Bool
    
    public func firstIndex(of element: Element) -> Int? where Element: Equatable
    public func firstIndex(where predicate: (Element) -> Bool) -> Int?
    
    public func joined(separator: String = "") -> String where Element == Character
    public func joined(separator: String = "") -> String where Element == String
    
    public static func == <Element: Equatable>(lhs: [Element], rhs: [Element]) -> Bool
}

// Dictionary type
public struct Dictionary<Key, Value> where Key: Hashable {
    public init()
    public init(minimumCapacity: Int)
    public init<S: Sequence>(_ sequence: S) where S.Element == (Key, Value)
    
    public var count: Int
    public var isEmpty: Bool
    public var keys: Dictionary<Key, Value>.Keys
    public var values: Dictionary<Key, Value>.Values
    
    public subscript(key: Key) -> Value?
    
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value?
    public mutating func removeValue(forKey key: Key) -> Value?
    public mutating func removeAll(keepingCapacity: Bool = false)
    
    public func mapValues<T>(_ transform: (Value) -> T) -> [Key: T]
    public func filter(_ isIncluded: ((key: Key, value: Value)) -> Bool) -> [Key: Value]
    
    public func contains(where predicate: ((key: Key, value: Value)) -> Bool) -> Bool
    
    public static func == <Key: Equatable, Value: Equatable>(lhs: [Key: Value], rhs: [Key: Value]) -> Bool
}

// Optional type
public enum Optional<Wrapped> {
    case none
    case some(Wrapped)
    
    public init(_ value: Wrapped?)
    
    public var unsafelyUnwrapped: Wrapped
    
    public func map<U>(_ transform: (Wrapped) -> U) -> U?
    public func flatMap<U>(_ transform: (Wrapped) -> U?) -> U?
    
    public static func ?? <T>(optional: T?, defaultValue: @autoclosure () -> T) -> T
}

// Result type
public enum Result<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
    
    public init(catching body: () throws -> Success)
    
    public var isSuccess: Bool
    
    public func get() throws -> Success
    
    public func map<NewSuccess>(_ transform: (Success) -> NewSuccess) -> Result<NewSuccess, Failure>
    public func flatMap<NewSuccess>(_ transform: (Success) -> Result<NewSuccess, Failure>) -> Result<NewSuccess, Failure>
    public func mapError<NewFailure>(_ transform: (Failure) -> NewFailure) -> Result<Success, NewFailure> where NewFailure: Error
}

// Protocol definitions
public protocol Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool
}

public protocol Hashable: Equatable {
    var hashValue: Int { get }
    func hash(into hasher: inout Hasher)
}

public protocol Comparable: Equatable {
    static func < (lhs: Self, rhs: Self) -> Bool
    static func <= (lhs: Self, rhs: Self) -> Bool
    static func >= (lhs: Self, rhs: Self) -> Bool
    static func > (lhs: Self, rhs: Self) -> Bool
}

public protocol Error {
    var localizedDescription: String { get }
}

public protocol Sequence {
    associatedtype Element
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Element
    
    func makeIterator() -> Iterator
}

public protocol Collection: Sequence {
    associatedtype Index: Comparable
    
    var startIndex: Index { get }
    var endIndex: Index { get }
    
    subscript(position: Index) -> Element { get }
    
    func index(after i: Index) -> Index
}

// Common Foundation types
public struct URL: Equatable, Hashable {
    public init?(string: String)
    public init(fileURLWithPath path: String)
    
    public var absoluteString: String
    public var path: String
    public var lastPathComponent: String
    public var pathExtension: String
    
    public func appendingPathComponent(_ pathComponent: String) -> URL
    public func appendingPathExtension(_ pathExtension: String) -> URL
}

public struct Date: Equatable, Hashable, Comparable {
    public init()
    public init(timeIntervalSince1970: Double)
    
    public static var now: Date
    
    public static func < (lhs: Date, rhs: Date) -> Bool
    
    public func timeIntervalSince(_ date: Date) -> TimeInterval
    public var timeIntervalSince1970: TimeInterval
}

public struct Data: Equatable, Hashable {
    public init()
    public init<S: Sequence>(bytes: S) where S.Element == UInt8
    
    public var count: Int
    public var isEmpty: Bool
    
    public subscript(index: Int) -> UInt8
    
    public func base64EncodedString() -> String
}