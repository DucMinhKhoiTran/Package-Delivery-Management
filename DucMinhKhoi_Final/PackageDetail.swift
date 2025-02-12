//
//  PackageDetail.swift
//  DucMinhKhoi_Final
//
//  Created by Duc Minh Khoi Tran on 2025-02-11.
//

import SwiftUI

struct PackageDetail: View {
    
    @ObservedObject var package: PackageModel
    @EnvironmentObject var packageStore: PackageStore
    @Environment(\.dismiss) var dismiss
    
    private let carriers = ["FedEx", "DHL", "UPS"]
    var body: some View {
        Form {
            Section(header: Text("Package Details")) {
                
                // Package Id cannot edit
                HStack {
                    Text("Package ID:")
                    Spacer()
                    Text("\(package.packageID)")
                        .fontWeight(.bold)
                } //HStack
                
                // Editable fields
                TextField("Delivery Address", text: $package.deliveryAddress)
                DatePicker("Delivery Date", selection: $package.deliveryDate, displayedComponents: .date)
                Picker("Carrier", selection: $package.carrier) {
                    ForEach (carriers, id:\.self) { carrier in
                        Text(carrier)
                    }
                }
                Toggle("Delivered", isOn: $package.isDelivered)
            } //Section
            .font(.headline)
            .foregroundColor(.blue)
        }// Form
        .navigationTitle(Text("Package Detail"))
        .navigationBarItems(trailing:
            Button("Save") {
              //Save updates by calling save method in PackageStore
            packageStore.savePackages()
            dismiss()
           }
       )
    }
}

