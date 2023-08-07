//
//  StructClassActorB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 31.07.23.
//

import SwiftUI

struct StructClassActorB: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                structTest1()
            }
    }
}

struct StructClassActorB_Previews: PreviewProvider {
    static var previews: some View {
        StructClassActorB()
    }
}

struct MyStruct {
    var title: String
}

extension StructClassActorB {
    
    private func runTest() {
         
    }
    
    private func structTest1() {
        let objectA = MyStruct(title: "Starting title")
        print("objectA: \(objectA.title)")
        
        var objectB = objectA
        print("objectB: \(objectB.title)")
        
        objectB.title = "Second title"
        print("ObjectB title changed")
        
        print("objectA: \(objectA.title)")
        print("objectB: \(objectB.title)")
    }
    
    
}
