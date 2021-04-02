//
//  Graph.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/4/2.
//

import Foundation

public struct Vertex<T> {
    public let index: Int
    public let data: T
}

extension Vertex: Hashable {
    public static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        lhs.index == rhs.index
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }
}


extension Vertex: CustomStringConvertible {
    public var description: String {
        "\(index): \(data)"
    }
}


public struct Edge<T> {
    public let source: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
}

extension Edge: Hashable {
    public static func == (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        lhs.source == rhs.source && lhs.destination == rhs.destination && lhs.weight == rhs.weight
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(source)
        hasher.combine(destination)
        hasher.combine(weight)
    }
}

public enum EdgeType {
    case directed
    case undirected
}

public protocol Graph {
    associatedtype Element
    
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
}

extension Graph {
    public func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    public func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
}

public class AdjacencyList<T>: Graph {
    private(set) var adjacencies: [Vertex<T>: [Edge<T>]] = [:];
    
    public init() {}
    
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }
    
    public func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencies[source]?.append(edge)
    }
    
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        adjacencies[source] ?? []
    }
    
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        return edges(from: source)
            .first{ $0.destination == destination }?
            .weight
    }
}

public class AdjacencyMatrix<T>: Graph {
    private(set) var vertices: [Vertex<T>] = []
    private(set) var weights: [[Double?]] = []
    
    public init() {}
    
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: vertices.count, data: data)
        vertices.append(vertex)
        
        for i in 0..<weights.count {
            weights[i].append(nil)
        }
        let row = [Double?](repeating: nil, count: vertices.count)
        weights.append(row)
        
        return vertex
    }
    
    public func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        weights[source.index][destination.index] = weight
    }
    
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges: [Edge<T>] = []
        for column in 0..<weights.count {
            if let weight = weights[source.index][column] {
                edges.append(Edge(source: source, destination: vertices[column], weight: weight))
            }
        }
        return edges
    }
    
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        weights[source.index][destination.index]
    }
    
    var matrixItems: [String] {
        var items: [String] = []
        
        items.append("")
        items.append(contentsOf: vertices.map { "\($0.data)" })


        for i in 0..<weights.count {
            let rowWeight = weights[i]
            
            items.append("\(vertices[i])")
            items.append(contentsOf: rowWeight.map { "\(Int($0 ?? 0))" })
        }
        
        return items
    }
}
