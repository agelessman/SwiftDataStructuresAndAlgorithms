//
//  QueueView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/19.
//

import SwiftUI

enum QueueType {
    case array
    case doubleLink
}

class QueueViewModel: ObservableObject {
    @Published var values: [Int] = []
    
    @Published var queueType = QueueType.array
    
    var queueArray = QueueArray<Int>()
    
    var count = 1
    
    func enqueue() {
        switch queueType {
        case .array:
            _ = queueArray.enqueue(count)
            values = queueArray.values
        default:
            break
        }
        
        count += 1
    }
    
    func dequeue() {
        switch queueType {
        case .array:
            _ = queueArray.dequeue()
            values = queueArray.values
        default:
            break
        }
    }
}

struct QueueView: View {
    @StateObject private var viewModel = QueueViewModel()
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<viewModel.values.count, id: \.self) { index in
                    Text("\(viewModel.values[index])")
                        .padding()
                        .background(Color.green)
                }
            }
            
            Picker("", selection: $viewModel.queueType) {
                Text("array").tag(QueueType.array)
                Text("doubleLink").tag(QueueType.doubleLink)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button("enqueue") {
                withAnimation {
                    viewModel.enqueue()
                }
            }
            
            Button("dequeue") {
                withAnimation {
                    viewModel.dequeue()
                }
            }
        }
    }
}

struct QueueView_Previews: PreviewProvider {
    static var previews: some View {
        QueueView()
    }
}
