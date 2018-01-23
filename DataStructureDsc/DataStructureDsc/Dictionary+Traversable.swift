// Copyright (c) 2018 NUS CS3217. All rights reserved.

extension Dictionary where Value: Collection, Value.Iterator.Element == Key {
    typealias Node = Key
    typealias AdjacentNodes = Value

    /// Returns a generator that traverses the collection's nodes in the
    /// breadth-first order from a start node.
    /// - Parameter node: The start node for the traversal
    /// - Returns: BreadthFirstOrderGenerator that starts from the given node
    ///   and traverses through the collection's nodes in breadth-first order
    func breadthFirstOrderGeneratorFromNode(_ node: Node) -> BreadthFirstOrderGenerator<Node, AdjacentNodes>? {
        return BreadthFirstOrderGenerator(graph: self, start: node)
    }

    /// Returns a generator that traverses the collection's nodes in the
    /// depth-first order from a start node.
    /// - Parameter node: The start node for the traversal
    /// - Returns: DepthFirstOrderGenerator that starts from the given node and
    ///   traverses through the collection's nodes in depth-first order
    func depthFirstOrderGeneratorFromNode(_ node: Node) -> DepthFirstOrderGenerator<Node, AdjacentNodes>? {
        return DepthFirstOrderGenerator(graph: self, start: node)
    }

    /// Returns an array of nodes traversed in the breadth-first order from a
    /// start node.
    /// - Parameter node: The start node for the traversal
    /// - Returns: list of nodes in the order that they are traversed
    func nodesSequenceInBreadthFirstOrderFromNode(_ node: Node) -> [Node] {
        guard let bfsGenerator = breadthFirstOrderGeneratorFromNode(node) else {
            return []
        }

        return Array(bfsGenerator)
    }

    /// Returns an array of nodes traversed in the depth-first order from a
    /// start node.
    /// - Parameter node: The start node for the traversal
    /// - Returns: list of nodes in the order that they are traversed
    func nodesSequenceInDepthFirstOrderFromNode(_ node: Node) -> [Node] {
        guard let dfsGenerator = depthFirstOrderGeneratorFromNode(node) else {
            return []
        }

        return Array(dfsGenerator)
    }
}
