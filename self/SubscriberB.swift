//
//  SubscriberB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 21.08.23.
//

import SwiftUI
import Combine

class SubscriberVM: ObservableObject {
    
    @Published var count: Int = 0
    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text in
                
                if text.count > 3 {
                    return true
                }
                return false
            }
        // Not possible to weak self therefore not recommended
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                
                guard let self = self else { return }
                
                self.count += 1
                
//                if self.count == 3 {
//                    for item in cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
        
    }
    
    func addButtonSubscriber() {
        
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isvalid, count in
                guard let self = self else { return }
                if isvalid && count > 3 {
                    showButton = true
                } else {
                    showButton = false
                }
            }
            .store(in: &cancellables)
        
    }
    
}

struct SubscriberB: View {
    
    @StateObject var vm = SubscriberVM()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text(vm.textIsValid.description)
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color.gray)
                .cornerRadius(10)
                .overlay(alignment: .trailing, content: {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                    vm.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                    .font(.title)
                    .padding(.trailing)
                })
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            }
            .disabled(!vm.showButton)

        }
        .padding()
    }
}

struct SubscriberB_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberB()
    }
}
