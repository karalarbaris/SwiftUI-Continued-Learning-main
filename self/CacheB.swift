//
//  CacheB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 23.08.23.
//

import SwiftUI


class CacheManagerB {
    
    static let instance = CacheManagerB()
    
    // with private we can only initialize cachemanager within the class
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String {
        
        imageCache.setObject(image, forKey: name as NSString)
        return("Added to cache")
    }
    
    func remove(name: String) -> String {
        
        imageCache.removeObject(forKey: name as NSString)
        return("Removed from cache")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
    
}


class CacheVM: ObservableObject {
    
    @Published var startingImage: UIImage?
    @Published var cachedImage: UIImage?
    @Published var infoMessage: String = ""
    
    let imageName: String = "brs"
    let manager = CacheManagerB.instance
    
    init() {
        getImageFromAssetFolder()
    }
    
    func getImageFromAssetFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
        cachedImage = nil
    }
    
    func getFromCache() {
        
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = manager.get(name: imageName)
            infoMessage = "Got image from cache"
        } else {
            infoMessage = "Image not found on cache"
        }
        
    }
    
    
}

struct CacheB: View {
    
    @StateObject var vm = CacheVM()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                    
                }
                
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundColor(.purple)
                
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding()
                        .background(.red)
                        .cornerRadius(10)
                }
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                    
                }
                
                
                Spacer()
                
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

struct CacheB_Previews: PreviewProvider {
    static var previews: some View {
        CacheB()
    }
}
