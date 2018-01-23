// Copyright (c) 2018 NUS CS3217. All rights reserved.

/**
 A generic `Stack` class whose elements are last-in, first-out.

 - Authors: CS3217
 - Date: 2018
 */

struct Stack<T> {

    var head: Node<T>?
    var countNum: Int = 0

    /// Adds an element to the top of the stack.
    /// - Parameter item: The element to be added to the stack
    mutating func push(_ item: T) {
        if head == nil {
            head = Node<T>(as: item, to: nil) //initialise the head node
        } else {
            let newNode = Node<T>(as: item, to: nil) //initialise a new node
            newNode.next = head //add the node to the front of the linked list
            head = newNode
        }
        countNum += 1
    }

    /// Removes the element at the top of the stack and return it.
    /// - Returns: element at the top of the stack
    mutating func pop() -> T? {
        guard let nodeToDelete = head
            else { return nil }
        head = head?.next //update head to the next node to remove the original head
        countNum -= 1
        return nodeToDelete.value
    }

    /// Returns, but does not remove, the element at the top of the stack.
    /// - Returns: element at the top of the stack
    func peek() -> T? {
        return head?.value
    }

    /// The number of elements currently in the stack.
    var count: Int {
        return countNum
    }

    /// Whether the stack is empty.
    var isEmpty: Bool {
        return countNum == 0
    }

    /// Removes all elements in the stack.
    mutating func removeAll() {
        head = nil
        countNum = 0
    }

    /// Returns an array of the elements in their respective pop order, i.e.
    /// first element in the array is the first element to be popped.
    /// - Returns: array of elements in their respective pop order
    func toArray() -> [T] {
        var result: [T] = []
        var iTer = head //a node pointer to iterate through this stack
        var index = 0
        while let node = iTer {
            guard let valueToAppend = node.value //if not the end of the stack
                else { return result }
            result.append(valueToAppend) //append to the array
            index += 1 //update index
            iTer = node.next //update to the next node in the linked list
        }
        return result
    }
}
