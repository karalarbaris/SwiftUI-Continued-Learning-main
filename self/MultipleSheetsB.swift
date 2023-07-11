//
//  MultipleSheetsB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 11.07.23.
//

import SwiftUI

struct RandomModelB: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 1. use binding
// 2. use multiple .sheets
// 3. use $item

struct MultipleSheetsB: View {
    
    @State var selectedModel: RandomModelB?
//    @State var showSheet: Bool = false
//    @State var showSheet2: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                                selectedModel = RandomModelB(title: "one")
//                showSheet.toggle()
            }
            
            Button("Button 2") {
                                selectedModel = RandomModelB(title: "two")
//                showSheet2.toggle()
            }
            
            
        }
        .sheet(item: $selectedModel) { model in
            NextScreenb(selectedModel: model)
        }
    }

}

struct NextScreenb: View {
    
    let selectedModel: RandomModelB
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetsB_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsB()
    }
}
