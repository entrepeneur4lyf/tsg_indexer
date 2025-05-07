// A simple JavaScript file to test the TSG indexer

class User {
    constructor(id, name, email) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.active = true;
    }
    
    deactivate() {
        this.active = false;
    }
    
    isActive() {
        return this.active;
    }
}

function findUserById(users, id) {
    return users.find(user => user.id === id);
}

function main() {
    const users = [
        new User(1, "Alice", "alice@example.com"),
        new User(2, "Bob", "bob@example.com"),
        new User(3, "Charlie", "charlie@example.com")
    ];
    
    const user = findUserById(users, 2);
    if (user) {
        console.log(`Found user: ${user.name} (${user.email})`);
        
        if (user.isActive()) {
            console.log("User is active");
        } else {
            console.log("User is not active");
        }
    } else {
        console.log("User not found");
    }
}

main();