//
//  QueueView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/19.
//

import SwiftUI
import Combine

enum QueueType {
    case array
    case doublyLinkedList
    case ringBuffer
    case doubleStack
}

class QueueViewModel: ObservableObject {
    @Published var values: [Int] = []
    
    @Published var queueType = QueueType.array
    
    var queueArray = QueueArray<Int>()
    var queueDoublyLinkedList = QueueDoublyLinkedList<Int>()
    var queueRingBuffer = QueueRingBuffer<Int>(count: 20)
    var queueDoubleStack = QueueStack<Int>()
    
    var anyCancellables = Set<AnyCancellable>()
    
    var count = 1
    
    init() {
        $queueType
            .delay(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] someValue in
                switch someValue {
                case .array:
                    self?.values = self?.queueArray.values ?? []
                case .doublyLinkedList:
                    self?.values = self?.queueDoublyLinkedList.values ?? []
                case .ringBuffer:
                    self?.values = self?.queueRingBuffer.values ?? []
                case .doubleStack:
                    self?.values = self?.queueDoubleStack.values ?? []
                }
            }
            .store(in: &anyCancellables)
    }
    
    func enqueue() {
        switch queueType {
        case .array:
            _ = queueArray.enqueue(count)
            values = queueArray.values
        case .doublyLinkedList:
            _ = queueDoublyLinkedList.enqueue(count)
            values = queueDoublyLinkedList.values
        case .ringBuffer:
            _ = queueRingBuffer.enqueue(count)
            values = queueRingBuffer.values
        case .doubleStack:
            _ = queueDoubleStack.enqueue(count)
            values = queueDoubleStack.values
        }
        
        count += 1
    }
    
    func dequeue() {
        switch queueType {
        case .array:
            _ = queueArray.dequeue()
            values = queueArray.values
        case .doublyLinkedList:
            _ = queueDoublyLinkedList.dequeue()
            values = queueDoublyLinkedList.values
        case .ringBuffer:
            _ = queueRingBuffer.dequeue()
            values = queueRingBuffer.values
        case .doubleStack:
            _ = queueDoubleStack.dequeue()
            values = queueDoubleStack.values
        }
    }
    
    var color: Color {
        switch queueType {
        case .array:
            return Color.green
        case .doublyLinkedList:
            return Color.blue
        case .ringBuffer:
            return Color.orange
        case .doubleStack:
            return Color.purple
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
                        .background(viewModel.color)
                }
            }
            
            Picker("", selection: $viewModel.queueType) {
                Text("array").tag(QueueType.array)
                Text("doubleLink").tag(QueueType.doublyLinkedList)
                Text("ringBuffer").tag(QueueType.ringBuffer)
                Text("doubleStack").tag(QueueType.doubleStack)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button("enqueue") {
                withAnimation {
                    viewModel.enqueue()
                }
            }
            .padding(.vertical, 20)
            
            Button("dequeue") {
                withAnimation {
                    viewModel.dequeue()
                }
            }
            .padding(.vertical, 10)
        }
    }
}

struct QueueView_Previews: PreviewProvider {
    static var previews: some View {
        QueueView()
    }
}
