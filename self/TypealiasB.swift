//
//  TypealiasB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 14.08.23.
//

import SwiftUI

struct MovieModelB {
    let title: String
    let director: String
    let count: Int
}

typealias TVModelB = MovieModel

struct TypealiasB: View {
    
    @State var item: TVModelB = TVModelB(title: "movie title", director: "Baro", count: 2)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

struct TypealiasB_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasB()
    }
}
