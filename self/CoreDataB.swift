//
//  CoreDataB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 07.08.23.
//

import SwiftUI
import CoreData

class CoreDataVM: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error)")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error)")
        }
        
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving \(error)")
        }
    }
    
    
    
}


struct CoreDataB: View {
    
    @StateObject var vm = CoreDataVM()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add fruit here..", text: $textFieldText)
                    .font(.headline)
                    .padding()
                    .background(Color.gray)
                    .frame(height: 55)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }

                
                Spacer()
                
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "No name")
                            .onTapGesture {
//                                updateFruit(entity: entity)
                            }
                    }
                    .onDelete { indexSet in
                        vm.deleteFruit(indexSet: indexSet)
                    }
                }
                
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataB_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataB()
    }
}
