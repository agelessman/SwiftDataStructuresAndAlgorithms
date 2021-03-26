//
//  BinarySearchView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/26.
//

import SwiftUI

struct BinarySearchView: View {
    @State private var searchIndex = -1
    @State private var numbers = [1, 5, 15, 17, 19, 22, 24, 31, 35, 40, 44, 50, 55, 65, 87, 292, 333]
    @State private var searchText = ""
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<numbers.count, id: \.self) { index in
                    Text("\(numbers[index])")
                        .frame(width: 60, height: 60)
                        .background(Circle().foregroundColor(index == searchIndex ? .orange : .green))
                }
            }
            .padding(.horizontal)
            
            HStack {
                TextField("请输入要搜索的数字", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("确定") {
                    withAnimation {
                        searchIndex = numbers.binarySearch(for: Int(searchText) ?? -1, in: nil) ?? -1
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct BinarySearchView_Previews: PreviewProvider {
    static var previews: some View {
        BinarySearchView()
    }
}
