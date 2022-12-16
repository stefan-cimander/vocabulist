//
//  WordsOverview.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 26.11.22.
//

import SwiftUI

struct WordsOverview: View {
    
    let title: String
    let chapter: Chapter?
    
    @EnvironmentObject private var wordsStore: WordsStore
    @Environment(\.openWindow) private var openWindow
    
    @State private var showExerciseDialog = false
    @State private var showAddWordDialog = false
    
    private var wordsOfChapter: [Word] {
        wordsStore.words.filter { word in chapter == nil || word.chapter?.id == chapter?.id }
    }
    
    var body: some View {
        #if os(iOS)
        WordsListView(words: wordsOfChapter)
            .toolbar { toolbar }
        #elseif os(macOS)
        WordsTableView(words: wordsOfChapter)
            .navigationTitle(title)
            .toolbar { toolbar }
        #endif
    }
    
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        #if os(macOS)
        ToolbarItemGroup(placement: .principal) {
            Button(action: { showExerciseDialog = true }) {
                Label("Practice words", systemImage: "play.fill")
            }
            .sheet(isPresented: $showExerciseDialog) {
                ExerciseView()
            }
        }
        ToolbarItemGroup{
            Spacer()
        }
        #endif
        if chapter != nil {
            ToolbarItemGroup {
                Button(action: { showAddWordDialog.toggle() }) {
                    Label("Add word", systemImage: "plus")
                }
                .sheet(isPresented: $showAddWordDialog) {
                    AddWordView(chapter: chapter!)
                }
            }
        }
    }
}
