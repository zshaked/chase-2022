//
//  List_App_With_APIApp.swift
//  List App With API
//
//  Created by 123456 on 11/8/21.
//

import SwiftUI

@main
struct List_App_With_APIApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
