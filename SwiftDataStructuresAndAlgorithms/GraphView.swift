//
//  GraphView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/4/2.
//

import SwiftUI

class GraphViewModel: ObservableObject {
    @Published var graph = AdjacencyList<String>()
    @Published var matrix = AdjacencyMatrix<String>()
    
    init() {
        addData(graph)
        addData(matrix)
    }
    
    func addData<T: Graph>(_ graph: T) where T.Element == String {
        let singapore = graph.createVertex(data: "Singapore")
        let tokyo = graph.createVertex(data: "Tokyo")
        let hongKong = graph.createVertex(data: "Hong Kong")
        let detroit = graph.createVertex(data: "Detroit")
        let sanFrancisco = graph.createVertex(data: "San Francisco")
        let washingtonDC = graph.createVertex(data: "Washington DC")
        let austinTexas = graph.createVertex(data: "Austin Texas")
        let seattle = graph.createVertex(data: "Seattle")

        graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
        graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
        graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
        graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
        graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
        graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
        graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
        graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
        graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
        graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
        graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
        graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)
    }
}

struct GraphView: View {
    @StateObject private var viewModel = GraphViewModel()
    
    private  var columns: [GridItem] {
        [GridItem](repeating: GridItem(.fixed(170)), count: viewModel.matrix.vertices.count + 1)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ScrollView(.horizontal) {
                    VStack(alignment: .leading) {
                        ForEach(Array(viewModel.graph.adjacencies.keys), id: \.self) { key in
                            HStack {
                                Text("\(key.data)")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.blue)
                                
                                ForEach(viewModel.graph.edges(from: key), id: \.self) { edge in
                                    HStack(spacing: 0) {
                                        Text("\(Int(edge.weight ?? 0.0))")
                                            .foregroundColor(.white)
                                        
                                        Text("\(edge.destination.data)")
                                            .foregroundColor(.red)
                                            .padding(.leading, 5)
                                            
                                    }
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.green)
                                }
                            }
                            
                        }
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.purple.opacity(0.5))
                
                ScrollView(.horizontal) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<viewModel.matrix.matrixItems.count, id: \.self) { index in
                            Text(viewModel.matrix.matrixItems[index])
                                .foregroundColor(.white)
                                .frame(width: 170, height: 50)
                                .background(Color.green)
                            
                        }
                    }
                }

            }
        }

    }

}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
