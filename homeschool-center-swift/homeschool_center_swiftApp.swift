//
//  homeschool_center_swiftApp.swift
//  homeschool-center-swift
//
//  Created by Lena Eivy on 3/6/23.
//

import SwiftUI


@main
struct homeschool_center_swiftApp: App {
    init() {
        let defaults = UserDefaults.standard
        let defaultValues = ["studentInfo": [String: Int]()]
        defaults.register(defaults: defaultValues)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
