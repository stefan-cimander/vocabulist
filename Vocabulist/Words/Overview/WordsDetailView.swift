//
//  WordsDetailView.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 26.11.22.
//

import SwiftUI

struct WordsDetailView: View {
    
    let title: String
    let chapter: Chapter?
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Word.creationDate, ascending: true)], animation: .default)
    private var words: FetchedResults<Word>
    
    @State private var showAddWordDialog = false
    
    private var wordsOfChapter: [Word] {
        words.filter { word in chapter == nil || word.chapter?.id == chapter?.id }
    }
    
    var body: some View {
        WordOverview(words: wordsOfChapter, onDelete: deleteWords)
            .toolbar {
                ToolbarItem {
                    Button(action: { showAddWordDialog.toggle() }) {
                        Label("Add word", systemImage: "plus")
                    }
                    .sheet(isPresented: $showAddWordDialog) {
                        AddWordView(onAdd: addWord)
                    }
                }
            }
            #if os(macOS)
            .navigationTitle(title)
            #endif
    }
    
    private func addWord(with input: AddWordInput) {
        withAnimation {
            let word = Word(context: viewContext)
            word.foreignName = input.foreignName
            word.nativeName = input.nativeName
            word.creationDate = Date()
            word.level = 1
            word.chapter = chapter
            try? viewContext.save()
        }
    }
    
    private func deleteWords(at offsets: IndexSet) {
        withAnimation {
            offsets.map { words[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}
