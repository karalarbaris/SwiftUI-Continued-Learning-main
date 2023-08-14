//
//  WeakSelfB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 14.08.23.
//

import SwiftUI

struct WeakSelfB: View {
    
    @AppStorage("countB") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        
        NavigationView {
            NavigationLink("Navigate") {
                WeakSelfSecondScreenB()
            }
            .navigationTitle("Screen 1")
        }
        .overlay(alignment: .topTrailing) {
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            
        }
    }
}

struct WeakSelfSecondScreenB: View {
    
    @StateObject var vm = WeakSelfSecondScreenVM()
    
    var body: some View {
        VStack {
            Text("Second view")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenVM: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        let currentCount = UserDefaults.standard.integer(forKey: "countB")
        UserDefaults.standard.set(currentCount + 1, forKey: "countB")
        print("initialize now")
        getData()
    }
    
    deinit {
        print("deinitialize now")
        let currentCount = UserDefaults.standard.integer(forKey: "countB")
        UserDefaults.standard.set(currentCount - 1, forKey: "countB")
    }
    
    func getData() {
        
        DispatchQueue.global().async {
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) { [weak self] in
            self?.data = "new data"
        }
    }
    
}

struct WeakSelfB_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfB()
    }
}
