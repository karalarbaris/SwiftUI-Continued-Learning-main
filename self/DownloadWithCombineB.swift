//
//  DownloadWithCombineB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 16.08.23.
//

import SwiftUI
import Combine

struct PostModelC: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineVM: ObservableObject {
    
    @Published var posts: [PostModelC] = []
    var cancellables = Set<AnyCancellable>()
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // 1. Sign up for monthly subscription for package to be delivered
        // 2. The company would prepare the package
        // 3. Receive the package at your front door
        // 4. Make sure the box isn't damaged
        // 5. Open and make sure the item is correct
        // 6. Use the item
        // 7. Cancellable at any time
        
        
        // 1. create the publisher
        // 2. subscribe publisher on background thread (It is done automatically with dataTaskPublisher but we're gonna do it anyway)
        // 3. receive on main thread
        // 4. tryMap (Check that the data is good)
        // 5. decode (decode data into PostModels)
        // 6. sink (Put the item in our app)
        // 7. store (cancel subscription if needed)
        
        
        URLSession.shared.dataTaskPublisher(for: url) // 1
            .subscribe(on: DispatchQueue.global(qos: .background)) // 2
            .receive(on: DispatchQueue.main) // 3
            .tryMap { data, response in // 4
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PostModelC].self, decoder: JSONDecoder()) // 5
            .sink { completion in // 6
                print("Completion: \(completion)")
                
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("There was an error: \(error)")
                }
                    
                
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables) // 7
        
    }
    
}

struct DownloadWithCombineB: View {
    
    @StateObject var vm = DownloadWithCombineVM()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithCombineB_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineB()
    }
}
