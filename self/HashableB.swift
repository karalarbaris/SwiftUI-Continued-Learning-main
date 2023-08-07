//
//  HashableB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 03.08.23.
//

import SwiftUI

struct HashableB: View {
    
    struct MyCustomModelB: Hashable {
        let title: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }
    }
    
    
    let data: [MyCustomModelB] = [ MyCustomModelB(title: "one"),
                                   MyCustomModelB(title: "two"),
                                   MyCustomModelB(title: "three")]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
            }
        }
    }
}

struct HashableB_Previews: PreviewProvider {
    static var previews: some View {
        HashableB()
    }
}
