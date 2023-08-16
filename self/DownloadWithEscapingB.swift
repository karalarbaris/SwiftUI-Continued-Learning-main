//
//  DownloadWithEscapingB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 15.08.23.
//

import SwiftUI

struct PostModelB: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscapingVM: ObservableObject {
    
    @Published var posts: [PostModelB] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) { data in
            guard let data = data else { return }
            guard let newPosts = try? JSONDecoder().decode([PostModelB].self, from: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.posts = newPosts
            }
        }
        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//
//            guard let data = data,
//                  error == nil,
//                  let response = response as? HTTPURLResponse,
//                  response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Error downloading data")
//                return
//            }
//
////            guard error == nil else {
////                print("Error: \(String(describing: error))")
////                return
////            }
////
////            guard let response = response as? HTTPURLResponse else {
////                print("Invalid response")
////                return
////            }
////
////            guard response.statusCode >= 200 && response.statusCode < 300 else {
////                print("Invalid status code \(response.statusCode)")
////                return
////            }
//
//            guard let newPost = try? JSONDecoder().decode(PostModelB.self, from: data) else { return }
//
//            DispatchQueue.main.async { [weak self] in
//                self?.posts.append(newPost)
//            }
//
//        }.resume()
        
    }
    
    func downloadData(fromURL url: URL, completion: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data")
                completion(nil)
                return
            }
            
            completion(data)
            
        }.resume()
    }
    
}

struct DownloadWithEscapingB: View {
    
    @StateObject var vm = DownloadWithEscapingVM()
    
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

struct DownloadWithEscapingB_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingB()
    }
}
