// Copyright (c) 2018 NUS CS3217. All rights reserved.

/**
 A generator that returns the nodes in the graph in depth-first search order,
 starting at the given node.

 - Authors: CS3217
 - Date: 2018
 */
public struct DepthFirstOrderGenerator<Key: Hashable, Value: Collection>: IteratorProtocol,
Sequence where Value.Iterator.Element == Key {

    var dict: [Key: Value]
    var cur: Key?
    var visitedList: [Key]
    var stack: Stack<Key>

    /// Constructs a `DepthFirstOrderGenerator` with the given graph and start
    /// node.
    /// - Parameters:
    ///   - graph: A dictionary of node to adjacency list pairs.
    ///   - start: The start node.
    public init?(graph: [Key: Value], start: Key) {
        dict = graph
        cur = start
        visitedList = []
        stack = Stack<Key>()
    }

    public func makeIterator() -> DepthFirstOrderGenerator<Key, Value> {
        return self
    }

    public mutating func next() -> Key? {
        var res: Key? //declare res node here so that we can always get it
        if let currentNode = cur { //if the cur is not nil, return its value
            visitedList.append(currentNode) //this node has been visited
            res = currentNode
        } else {
            //the current connected component has been exhausted
            return nil
        }

        //add current node's adjacent Nodes to the stack
        if let nodeToInspect = res {
            if let adjacentNodes = dict[nodeToInspect] { //if there are some adjacent nodes
                var iterator = adjacentNodes.makeIterator()
                var auxilaryStack = Stack<Key>() //for making the correct order to the next neighbor
                while let node = iterator.next() {
                    auxilaryStack.push(node) //add the new adjacent nodes to the stack
                }
                while !auxilaryStack.isEmpty {
                    if let valuePopped = auxilaryStack.pop() {
                        stack.push(valuePopped) //Use a stack to get the appropriate order
                    }
                }
            }
        }

        //update cur to the next node in the stack
        if stack.isEmpty {
            cur = nil
        } else {
            cur = stack.pop() //get the top of the stack

            while let value = cur {
                if visitedList.contains(value) {
                    cur = stack.pop() //node has been visited, should be disgarded
                } else {
                    break
                }
            }
        }
        return res //return the current node value
    }
}
