//
//  EscapingB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 14.08.23.
//

import SwiftUI

class EscapingVM: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
//        let newData = downloadData2()
//        text = newData
        
//        downloadData3 { [weak self] data in
//            self?.text = data
//        }
        
//        downloadData4 { [weak self] result in
//            self?.text = result.data
//        }
        
        downloadData5 { [weak self] result in
            self?.text = result.data
        }
    }
    
    func downloadData() -> String {
        return "New data!!"
    }
    
    func downloadData2(completion: (_ data: String) -> Void) {
        
        completion("new data22")
//        return "New data2"
    }
    
    func downloadData3(completion: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("new data3")
        }
    }
    
    func downloadData4(completion: @escaping (DownloadResultB) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(DownloadResultB(data: "new data4"))
        }
    }
    
    func downloadData5(completion: @escaping DownloadCompletionB) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(DownloadResultB(data: "new data4"))
        }
    }
    
}

struct DownloadResultB {
    let data: String
}

typealias DownloadCompletionB = (DownloadResultB) -> ()


struct EscapingB: View {
    
    @StateObject var vm = EscapingVM()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.brown)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingB_Previews: PreviewProvider {
    static var previews: some View {
        EscapingB()
    }
}
