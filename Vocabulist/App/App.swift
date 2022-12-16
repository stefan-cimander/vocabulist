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
    
    @StateObject private var chaptersStore = ChaptersStore()
    @StateObject private var settingsStore = SettingsStore()
    @StateObject private var wordsStore = WordsStore()

    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(chaptersStore)
                .environmentObject(settingsStore)
                .environmentObject(wordsStore)
                .onAppear(perform: setupInitialAppState)
        }
        .commands {
            SidebarCommands()
        }
        
        #if os(macOS)
        Window("Exercise", id: "exercise") {
            ExerciseView()
        }
        Settings {
            SettingsView()
                .environmentObject(settingsStore)
        }
        #endif
    }
    
    private func setupInitialAppState() {
        chaptersStore.loadAllChapters()
        wordsStore.loadAllWords()
        
        if chaptersStore.chapters.isEmpty {
            let chapterTitle = String(localized: "First chapter")
            chaptersStore.addChapter(withTitle: chapterTitle)
        }
    }
}
