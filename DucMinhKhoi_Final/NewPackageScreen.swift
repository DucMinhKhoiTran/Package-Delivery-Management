//
//  NewPackageScreen.swift
//  DucMinhKhoi_Final
//
//  Created by Duc Minh Khoi Tran on 2025-02-11.
//

import SwiftUI

struct NewPackageScreen: View {
    
    @EnvironmentObject var packageStore: PackageStore
    @Environment(\.dismiss) var dismiss
    
    @State private var packageID: String = ""
    @State private var deliveryAddress: String = ""
    @State private var deliveryDate: Date = Date()
    @State private var selectedCarrier: String = "FedEx"
    @State private var isDelivered: Bool = false
    
    private let carriers: [String] = ["FedEx", "USPS", "DHL"]
    
    
    var body: some View {
        Form {
            Section(header: Text("Package Information")
                .font(.headline)
                .foregroundColor(.blue)) {
                TextField("Enter Package ID", text: $packageID)
                    .keyboardType(.numberPad)
                TextField("Enter Delivery Address", text: $deliveryAddress)
            } //SEction
                
            Section(header: Text("Delivery Details")
                .font(.headline)
                .foregroundColor(.blue)) {
                    DatePicker("Expected Delivary Date", selection: $deliveryDate, displayedComponents: .date)
                    Picker("Carrier", selection: $selectedCarrier) {
                        ForEach(carriers, id: \.self) { carrier in
                            Text(carrier)
                        }
                    }
                    Toggle("Mark as Delivered", isOn: $isDelivered)
                } //Section
            
            Button(action: addPackage) {
                HStack {
                    Spacer()
                    Text("Add Package")
                        .fontWeight(.bold)
                    Spacer()
                }
            } //Button
        } //Form
        .navigationTitle(Text("New Package"))
    }
    
    func addPackage() {
        // Ensure required fields are not empty
        guard !packageID.isEmpty, !deliveryAddress.isEmpty else { return }
        let newPackage = PackageModel(packageID: packageID, deliveryAddress: deliveryAddress, deliveryDate: deliveryDate, carrier: selectedCarrier, isDelivered: isDelivered)
        packageStore.addPackage(newPackage)
        dismiss()
    }
}

#Preview {
    NewPackageScreen()
}
