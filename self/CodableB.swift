//
//  CodableB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 15.08.23.
//

import SwiftUI

struct CustomerModelB: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
    
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.points, forKey: .points)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
}

class CodableVM: ObservableObject {
    
    @Published var customer: CustomerModelB?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else { return }
        do {
            self.customer = try JSONDecoder().decode(CustomerModelB.self, from: data)
        } catch let error{
            print("Error decoding \(error)")
        }
    }
    
    func getJSONData() -> Data? {
        
        let customer = CustomerModel(id: "213", name: "sdfggfsd", points: 2323, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
//        let dictionary: [String:Any] = [
//            "id" : "12345",
//            "name" : "Joe",
//            "points" : 5,
//            "isPremium" : true
//        ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary)
        return jsonData
    }
    
}

struct CodableB: View {
    
    @StateObject var vm = CodableVM()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CodableB_Previews: PreviewProvider {
    static var previews: some View {
        CodableB()
    }
}
