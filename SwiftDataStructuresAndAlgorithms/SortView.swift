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
        
            Group {
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
                
                Button("基数排序") {
                    withAnimation {
                        sortedArray = array
                        sortedArray.radixSort()
                    }
                }
                
                Button("堆排序") {
                    withAnimation {
                        sortedArray = array
                        let heap = Heap(sort: >, elements: sortedArray)
                        sortedArray = heap.sorted()
                    }
                }
                
                Button("快速排序Naive") {
                    withAnimation {
                        sortedArray = array
                        sortedArray = quickSortNaive(sortedArray)
                    }
                }
                
                Button("快速排序Lomulo") {
                    withAnimation {
                        sortedArray = array
                        quickSortLomulo(&sortedArray, low: 0, high: array.count - 1)
                    }
                }
                
                Button("快速排序Hoare") {
                    withAnimation {
                        sortedArray = array
                        quickSortHoare(&sortedArray, low: 0, high: array.count - 1)
                    }
                }
                
                Button("快速排序Lomulo中位数优化") {
                    withAnimation {
                        sortedArray = array
                        quickSortMedian(&sortedArray, low: 0, high: array.count - 1)
                    }
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
