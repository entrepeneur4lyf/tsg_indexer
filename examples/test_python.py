# A simple Python file to test the TSG indexer

class User:
    def __init__(self, id, name, email):
        self.id = id
        self.name = name
        self.email = email
        self.active = True
    
    def deactivate(self):
        self.active = False
    
    def is_active(self):
        return self.active


def find_user_by_id(users, id):
    for user in users:
        if user.id == id:
            return user
    return None


def main():
    users = [
        User(1, "Alice", "alice@example.com"),
        User(2, "Bob", "bob@example.com"),
        User(3, "Charlie", "charlie@example.com"),
    ]
    
    user = find_user_by_id(users, 2)
    if user:
        print(f"Found user: {user.name} ({user.email})")
        
        if user.is_active():
            print("User is active")
        else:
            print("User is not active")
    else:
        print("User not found")


if __name__ == "__main__":
    main()