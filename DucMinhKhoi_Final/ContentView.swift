//
//  ContentView.swift
//  DucMinhKhoi_Final
//
//  Created by Duc Minh Khoi Tran on 2025-02-11.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var packageStore: PackageStore
    @State private var filterSelection: String = "All"
    
    // Options for filtering
    private let filterOptions: [String] = ["All", "Delivered", "In Transit"]
    
    // Filterd packages based on SElection
    var filteredPackages: [PackageModel] {
        switch filterSelection {
        case "Delivered":
            return packageStore.packages.filter { $0.isDelivered }
        case "In Transit":
            return packageStore.packages.filter { $0.isDelivered == false }
        default:
            return packageStore.packages
        }
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                // Picker to filter by status
                Picker("Filter by status", selection: $filterSelection) {
                    ForEach(filterOptions, id: \.self) { option in
                        Text(option)
                    }
                } // Picker
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // List of packages with delete func
                List {
                    ForEach(filteredPackages) { package in
                        NavigationLink(destination: PackageDetail(package: package)) {
                            PackageRow(package: package)
                        }
                    }
                    .onDelete(perform: deletePackages)
                } //List
            } //VStack
            .navigationBarTitle("Duc Minh Khoi Tran", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: NewPackageScreen()) {
                  Image(systemName: "plus")
                    .imageScale(.large)
               }
            )
        }//NagvigationView
    }
    
    func deletePackages(at offsets: IndexSet) {
        packageStore.removePackage(at: offsets)
    }
}

// A row view to display key package info
struct PackageRow: View {
    @ObservedObject var package: PackageModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Package ID: \(package.packageID)")
                .fontWeight(.bold)
            Text("Delivery Date: \(package.deliveryDate, style: .date)")
            Text("Status: \(package.status)")
                .foregroundColor(package.isDelivered ? .green : .orange)
        } //VStack
        .padding(.vertical, 5)
    }
    
    // Helper to format the date
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
    
