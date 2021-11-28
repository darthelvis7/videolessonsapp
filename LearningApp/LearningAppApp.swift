//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Elvis Cuevas on 11/28/21.
//

import SwiftUI

@main
struct LearningAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
