//
//  BackgroundThreadB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 11.08.23.
//

import SwiftUI

class BgThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("""
            Check 1
            \(Thread.isMainThread)
            \(Thread.current)
            """)
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("""
                Check 2
                \(Thread.isMainThread)
                \(Thread.current)
                """)
            }
        }
        
        
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
        }
        return data
    }
}

struct BackgroundThreadB: View {
    
    @StateObject var vm = BgThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadB_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadB()
    }
}
