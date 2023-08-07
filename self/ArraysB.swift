//
//  ArraysB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 05.08.23.
//

import SwiftUI

struct UserModelB: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationVM: ObservableObject {
    
    @Published var dataArray: [UserModelB] = []
    @Published var filteredArray: [UserModelB] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        
        // sort
//        filteredArray = dataArray.sorted { user1, user2 in
//            user1.points > user2.points
//        }
//
//        filteredArray = dataArray.sorted(by: { $0.points > $1.points })
        
        
        // filter
//        filteredArray = dataArray.filter({ user in
//            user.points > 50
//        })
        
//        filteredArray = dataArray.filter( { $0.isVerified })
        
        
        // map
//        mappedArray = dataArray.map({ user in
//            user.name ?? "Error"
//        })
        
//        mappedArray = dataArray.compactMap( { $0.name })
        
        mappedArray = dataArray
            .sorted(by: {$0.points > $1.points})
            .filter({ $0.isVerified })
            .compactMap({ $0.name})
        
    }
    
    func getUsers() {
        let user1 = UserModelB(name: "Nick", points: 5, isVerified: true)
        let user2 = UserModelB(name: "Chris", points: 0, isVerified: false)
        let user3 = UserModelB(name: nil, points: 20, isVerified: true)
        let user4 = UserModelB(name: "Emily", points: 50, isVerified: false)
        let user5 = UserModelB(name: "Samantha", points: 45, isVerified: true)
        let user6 = UserModelB(name: "Jason", points: 23, isVerified: false)
        let user7 = UserModelB(name: nil, points: 76, isVerified: true)
        let user8 = UserModelB(name: "Baro", points: 45, isVerified: false)
        let user9 = UserModelB(name: "Steve", points: 1, isVerified: true)
        let user10 = UserModelB(name: "Amanda", points: 100, isVerified: false)
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
        ])
    }
    
}

struct ArraysB: View {
    
    @StateObject var vm = ArrayModificationVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
            }
        }
    }
}

struct ArraysB_Previews: PreviewProvider {
    static var previews: some View {
        ArraysB()
    }
}
