//
//  DucMinhKhoi_FinalApp.swift
//  DucMinhKhoi_Final
//
//  Created by Duc Minh Khoi Tran on 2025-02-11.
//

import SwiftUI

@main
struct DucMinhKhoi_FinalApp: App {
    
    @StateObject var packageStore = PackageStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(packageStore)
        }
    }
}
