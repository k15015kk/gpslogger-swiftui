//
//  gpslogger_swiftuiApp.swift
//  gpslogger-swiftui
//
//  Created by 井上晴稀 on 2023/10/22.
//

import SwiftUI
import SwiftData

@main
struct gpslogger_swiftuiApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}
