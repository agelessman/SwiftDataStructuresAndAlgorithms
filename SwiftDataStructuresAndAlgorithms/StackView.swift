//
//  StackView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/19.
//

import SwiftUI

class StackViewModel: ObservableObject {
    @Published var text: String = ""
    
    var stack = Stack<Int>()
    
    var count = 1;
    
    func push() {
        stack.push(count)
        text = stack.description
        
        count += 1
    }
    
    func pop() {
        _ = stack.pop()
        text = stack.description
    }
}

struct StackView: View {
    @StateObject private var viewModel = StackViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.text)
                .padding()
                .border(Color.green)
            
            Button("push") {
                withAnimation {
                    viewModel.push()
                }
            }
            
            Button("pop") {
                withAnimation {
                    viewModel.pop()
                }
            }
        }
        .navigationTitle("Stack")
    }
}

struct StackView_Previews: PreviewProvider {
    static var previews: some View {
        StackView()
    }
}
