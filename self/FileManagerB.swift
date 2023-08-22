//
//  FileManagerB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 22.08.23.
//

import SwiftUI

class LocalFileManagerB {
    
    static let instance = LocalFileManagerB()
    let folderName: String = "BarisApp_Images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appending(path: folderName).path() else { return }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Success creating folder")
            } catch let error {
                print("Error creating folder \(error)")
            }
        }
        
    }
    
    func deleteFolder() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appending(path: folderName).path() else { return }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder")
        } catch let error {
            print("Error deleting folder \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            return("Error getting data")
        }
        
        guard let path = getPathForImage(name: name) else {
            return("Error getting path")
        }
        
        do {
            try data.write(to: path)
            print(path)
            return("success saving")
            
        } catch let error {
            return("Error saving \(error)")
        }
    }
    
    func getImage(name: String) -> UIImage? {
        
        guard let path = getPathForImage(name: name)?.path,
        FileManager.default.fileExists(atPath: path) else {
            print("File does not exist at path")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        
        guard let path = getPathForImage(name: name)?.path,
        FileManager.default.fileExists(atPath: path) else {
            return("File does not exist at path")
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return("Successfully deleted")
        } catch let error {
            return("Error deleting image \(error)")
        }
        
    }
    
    func getPathForImage(name: String) -> URL? {
        //        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //        let directory3 = FileManager.default.temporaryDirectory
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        guard let path = directory?.appending(path: folderName).appending(path: "\(name).jpg") else {
            print("Getting path error")
            return nil
        }
        return path
    }
    
}

class FileManagerVM: ObservableObject {
    
    @Published var image: UIImage?
    let imageName: String = "brs"
    let manager = LocalFileManagerB.instance
    
    @Published var infoMessage: String = ""
    
    init() {
        getImageFromAssetsFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
    
}

struct FileManagerB: View {
    
    @StateObject var vm = FileManagerVM()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FM")
                            .foregroundColor(.red)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                }
                
                Button {
                    vm.saveImage()
                } label: {
                    Text("Save to FM")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerB_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerB()
    }
}
