// Rust standard library core types that are treated as builtins

// Vec<T>
pub struct Vec<T> {
    // ...methods would go here
}

// String
pub struct String {
    // ...methods would go here  
}

// Option<T>
pub enum Option<T> {
    Some(T),
    None,
}

// Result<T, E>
pub enum Result<T, E> {
    Ok(T),
    Err(E),
}

// Box<T>
pub struct Box<T> {
    // ...methods would go here
}

// Rc<T>
pub struct Rc<T> {
    // ...methods would go here
}

// Arc<T>
pub struct Arc<T> {
    // ...methods would go here
}

// HashMap<K, V>
pub struct HashMap<K, V> {
    // ...methods would go here
}

// HashSet<T>
pub struct HashSet<T> {
    // ...methods would go here
}

// BTreeMap<K, V>
pub struct BTreeMap<K, V> {
    // ...methods would go here
}

// BTreeSet<T>
pub struct BTreeSet<T> {
    // ...methods would go here
}

// PhantomData<T>
pub struct PhantomData<T> {
    // ...methods would go here
}

// Mutex<T>
pub struct Mutex<T> {
    // ...methods would go here
}

// RwLock<T>
pub struct RwLock<T> {
    // ...methods would go here
}