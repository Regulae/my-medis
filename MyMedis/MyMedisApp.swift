//
//  MyMedisApp.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 20.06.21.
//

import SwiftUI

@main
struct MyMedisApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
