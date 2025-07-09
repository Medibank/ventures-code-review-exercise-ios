//
//  NewsApp.swift
//  News
//
//  Created by Mark Newton on 9/7/2025.
//

import SwiftUI

@main
struct NewsApp: App {
    @StateObject private var sourcesVM = SourcesViewModel()
    @StateObject private var savedVM = SavedViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(sourcesVM)
                .environmentObject(savedVM)
        }
    }
}
