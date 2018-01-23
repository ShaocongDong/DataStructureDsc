// Copyright (c) 2018 NUS CS3217. All rights reserved.

/**
 A generic `Queue` class whose elements are first-in, first-out.

 - Authors: CS3217
 - Date: 2018
 */

class Node<T> {
    /// A single node class for a linked list swift implementation
    var value: T?
    var next: Node?

    init (as value: T?, to next: Node<T>?) {
        self.value = value
        self.next = next
    }
}

public struct Queue<T> {

    var head: Node<T>?
    var cur: Node<T>?
    var countNum: Int = 0

    public init() {}
    
    /// Adds an element to the tail of the queue.
    /// - Parameter item: The element to be added to the queue
    public mutating func enqueue(_ item: T) {
        if head == nil {
            head = Node<T>(as: item, to: nil) //initialise a new head node
            cur = head //the current node pointer points to the head node
        } else {
            let newNode = Node<T>(as: item, to: nil) //initialise a new node
            if let currentNode = cur {
                currentNode.next = newNode //add to the end of the queue
                cur = newNode //current node pointer advances one node
            }
        }
        countNum += 1
    }

    /// Removes an element from the head of the queue and return it.
    /// - Returns: item at the head of the queue
    public mutating func dequeue() -> T? {
        if head == nil {
            return nil //the queue is empty
        } else {
            guard let headValue = head?.value //get the head node value
                else { return nil }
            head = head?.next //advances head node
            countNum -= 1 //the current number of node has been decreased by 1
            return headValue
        }
    }

    /// Returns, but does not remove, the element at the head of the queue.
    /// - Returns: item at the head of the queue
    public func peek() -> T? {
        return head?.value
    }

    /// The number of elements currently in the queue.
    public var count: Int {
        return countNum
    }

    /// Whether the queue is empty.
    public var isEmpty: Bool {
        return countNum == 0
    }

    /// Removes all elements in the queue.
    public mutating func removeAll() {
        head = nil
        countNum = 0
    }

    /// Returns an array of the elements in their respective dequeue order, i.e.
    /// first element in the array is the first element to be dequeued.
    /// - Returns: array of elements in their respective dequeue order
    public func toArray() -> [T] {
        var result: [T] = []
        var iTer = head //a node pointer to iterate through the queue
        var index = 0
        while let currentNode = iTer {
            if let valueToAppend = currentNode.value { //add current non-nil node value
                result.append(valueToAppend)
                index += 1 //update array index
                iTer = currentNode.next //update to the next node in the linked list
            }
        }
        return result
    }
}
