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
        ToolbarItem {
            Button(action: { showAddWordDialog.toggle() }) {
                Label("Add word", systemImage: "plus")
            }
            .disabled(chapter == nil)
            .sheet(isPresented: $showAddWordDialog) {
                AddWordView(chapter: chapter!)
            }
        }
    }
}
