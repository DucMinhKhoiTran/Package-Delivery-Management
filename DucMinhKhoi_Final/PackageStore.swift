//
//  PackageStore.swift
//  DucMinhKhoi_Final
//
//  Created by Duc Minh Khoi Tran on 2025-02-11.
//

import Foundation

class PackageStore: ObservableObject {
    @Published var packages: [PackageModel] = [] {
        didSet {
            savePackages()
        }
    }
    
    private let packagesSaveKey = "packages"
    
    init() {
        loadPackages()
    }
    
    func loadPackages() {
        if let savedData = UserDefaults.standard.data(forKey: packagesSaveKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([PackageModel].self, from: savedData) {
                self.packages = decoded
            }
        }
    }
    
    func savePackages() {
        let encoder = JSONEncoder()
        if let savedData = try? encoder.encode(packages) {
            UserDefaults.standard.set(savedData, forKey: packagesSaveKey)
        }
    }
    
    func addPackage(_ package: PackageModel) {
        packages.append(package)
    }
    
    func removePackage(at offset: IndexSet) {
        packages.remove(atOffsets: offset)
    }
}
