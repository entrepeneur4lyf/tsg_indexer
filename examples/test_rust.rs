// A simple Rust file to test the TSG indexer
#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(unused_imports)]

struct User {
    id: u64,
    name: String,
    email: String,
    active: bool,
}

impl User {
    fn new(id: u64, name: String, email: String) -> Self {
        Self {
            id,
            name,
            email,
            active: true,
        }
    }

    fn deactivate(&mut self) {
        self.active = false;
    }

    fn is_active(&self) -> bool {
        self.active
    }
}

fn find_user_by_id(users: &[User], id: u64) -> Option<&User> {
    users.iter().find(|user| user.id == id)
}

fn main() {
    let users = vec![
        User::new(1, "Alice".to_string(), "alice@example.com".to_string()),
        User::new(2, "Bob".to_string(), "bob@example.com".to_string()),
        User::new(3, "Charlie".to_string(), "charlie@example.com".to_string()),
    ];

    if let Some(user) = find_user_by_id(&users, 2) {
        println!("Found user: {} ({})", user.name, user.email);

        if user.is_active() {
            println!("User is active");
        } else {
            println!("User is not active");
        }
    } else {
        println!("User not found");
    }
}