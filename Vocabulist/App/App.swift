//
//  App.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 23.11.22.
//

import SwiftUI

@main
struct VocabulistApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @ObservedObject private var settingsStore = SettingsStore()

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(settingsStore)
        }
        .commands {
            SidebarCommands()
        }
        
        Settings {
            SettingsView()
                .environmentObject(settingsStore)
        }
    }
}
