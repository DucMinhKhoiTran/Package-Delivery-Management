//
//  PackageModel.swift
//  DucMinhKhoi_Final
//
//  Created by Duc Minh Khoi Tran on 2025-02-11.
//

import Foundation

class PackageModel: Identifiable, Codable, ObservableObject {
    let id: UUID
    let packageID: String
    @Published var deliveryAddress: String
    @Published var deliveryDate: Date
    @Published var carrier: String
    @Published var isDelivered: Bool
    
    // show status as text
    var status: String {
        isDelivered ? "Delivered" : "In Transit"
    }
    
    init(packageID: String,
         deliveryAddress: String,
         deliveryDate: Date,
         carrier: String,
         isDelivered: Bool) {
        self.id = UUID()
        self.packageID = packageID
        self.deliveryAddress = deliveryAddress
        self.deliveryDate = deliveryDate
        self.carrier = carrier
        self.isDelivered = isDelivered
    }
    
    // define custom code keys
    enum CodingKeys: String, CodingKey {
        case id, packageID, deliveryAddress, deliveryDate, carrier, isDelivered
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        packageID = try container.decode(String.self, forKey: .packageID)
        deliveryAddress = try container.decode(String.self, forKey: .deliveryAddress)
        deliveryDate = try container.decode(Date.self, forKey: .deliveryDate)
        carrier = try container.decode(String.self, forKey: .carrier)
        isDelivered = try container.decode(Bool.self, forKey: .isDelivered)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(packageID, forKey: .packageID)
        try container.encode(deliveryAddress, forKey: .deliveryAddress)
        try container.encode(deliveryDate, forKey: .deliveryDate)
        try container.encode(carrier, forKey: .carrier)
        try container.encode(isDelivered, forKey: .isDelivered)
    }
}
