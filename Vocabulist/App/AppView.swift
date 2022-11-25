//
//  AppView.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 23.11.22.
//

import SwiftUI
import CoreData

struct AppView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Word.creationDate, ascending: true)],
        animation: .default)
    private var words: FetchedResults<Word>
    
    @State private var selection: WordListCategory?
    @State private var showAddWordDialog = false

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                NavigationLink(value: WordListCategory.allWords) {
                    Label(WordListCategory.allWords.localized, systemImage: "list.bullet")
                }
            }
            .frame(minWidth: 224)
            .navigationTitle("Vocabulist")
        } detail: {
            WordOverview(words: words.map { $0 })
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
                .navigationTitle(WordListCategory.allWords.localized)
        }
        #if os(macOS)
        .task { selection = .allWords }
        #endif
    }
    
    private func addWord(with input: AddWordInput) {
        withAnimation {
            let newWord = Word(context: viewContext)
            newWord.foreignName = input.foreignName
            newWord.nativeName = input.nativeName
            newWord.creationDate = Date()
            newWord.level = 1
            try? viewContext.save()
        }
    }
}
