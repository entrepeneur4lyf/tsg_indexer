-- Lua example file for testing dynamic TSG generation

-- Simple function definition
function factorial(n)
    if n == 0 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

-- Table (object) definition
Person = {
    name = "",
    age = 0
}

-- Method for the Person table
function Person:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- Another method
function Person:greet()
    return "Hello, my name is " .. self.name .. " and I am " .. self.age .. " years old."
end

-- Create an instance
local person = Person:new{name = "Alice", age = 30}
print(person:greet())

-- Module pattern
local utils = {}

-- Module function
function utils.sum(t)
    local total = 0
    for _, v in ipairs(t) do
        total = total + v
    end
    return total
end

-- Module function with multiple returns
function utils.stats(t)
    local sum = utils.sum(t)
    local count = #t
    local avg = sum / count
    return sum, count, avg
end

-- Using the module
local numbers = {1, 2, 3, 4, 5}
local sum, count, avg = utils.stats(numbers)
print("Sum: " .. sum .. ", Count: " .. count .. ", Average: " .. avg)

-- Calculate and print factorial
print("Factorial of 5: " .. factorial(5))