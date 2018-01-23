// Copyright (c) 2018 NUS CS3217. All rights reserved.

/**
 A generator that returns the nodes in the graph in breadth-first search order,
 starting at the given node.

 - Authors: CS3217
 - Date: 2018
 */
struct BreadthFirstOrderGenerator<Key: Hashable, Value: Collection>: IteratorProtocol,
Sequence where Value.Iterator.Element == Key {

    var dict: [Key: Value]
    var cur: Key?
    var visitedList: [Key]
    var queue: Queue<Key>

    /// Constructs a `BreadthFirstOrderGenerator` with the given graph and start
    /// node.
    /// - Parameters:
    ///   - graph: A dictionary of node to adjacency list pairs.
    ///   - start: The start node.
    init?(graph: [Key: Value], start: Key) {
        self.dict = graph
        self.cur = start
        self.visitedList = []
        self.queue = Queue<Key>()
    }

    func makeIterator() -> BreadthFirstOrderGenerator<Key, Value> {
        return self
    }

    mutating func next() -> Key? {
        var res: Key? //declare res node here so that we can always get it
        if let currentNode = cur {
            visitedList.append(currentNode)
            if let adjacentNodes = dict[currentNode] {
                for node in adjacentNodes { //append the adjacent nodes in given order
                    queue.enqueue(node)
                }
            }
            res = currentNode
        } else {
            //the current connected component has been exhausted
            return nil
        }
        if queue.isEmpty { //the queue is empty, we have come to the end of the traversal
            cur = nil
        } else {
            cur = queue.dequeue() //update cur to the next value in the queue

            //check if this value has been visited before
            while let value = cur {
                if visitedList.contains(value) {
                    cur = queue.dequeue() //nodes having been visited should be discarded
                } else {
                    break
                }
            }
        }
        return res //return the value of the current node
    }

}
