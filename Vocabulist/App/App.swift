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
    
    @StateObject private var settingsStore = SettingsStore()
    @StateObject private var wordsStore = WordsStore()

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(settingsStore)
                .environmentObject(wordsStore)
                .onAppear(perform: wordsStore.loadAllWords)
        }
        .commands {
            SidebarCommands()
        }
        
        #if os(macOS)
        Settings {
            SettingsView()
                .environmentObject(settingsStore)
        }
        #endif
    }
}
