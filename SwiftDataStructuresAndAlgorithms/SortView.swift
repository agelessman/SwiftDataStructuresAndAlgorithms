//
//  SortView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/30.
//

import SwiftUI

struct SortView: View {
    @State private var array: [Int] = [14, 5, 3, 8, 11, 23]
    @State private var sortedArray: [Int] = []
    
    var body: some View {
        VStack {
            
            HStack {
                Text("未排序：")
                
                ForEach(array, id: \.self) { v in
                    Text("\(v)")
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(Color.orange)
                }
            }
            
            HStack {
                ForEach(sortedArray, id: \.self) { v in
                    Text("\(v)")
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(Color.green)
                }
            }
        
            
            Button("冒泡排序") {
                withAnimation {
                    sortedArray = array
                    bubbleSort(&sortedArray)
                }
            }
            
            Button("选择排序") {
                withAnimation {
                    sortedArray = array
                    selectionSort(&sortedArray)
                }
            }
            
            Button("插入排序") {
                withAnimation {
                    sortedArray = array
                    insertionSort(&sortedArray)
                }
            }
            
            Button("归并排序") {
                withAnimation {
                    sortedArray = array
                    sortedArray = mergeSort(sortedArray)
                }
            }
        }
    }
}

struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView()
    }
}
