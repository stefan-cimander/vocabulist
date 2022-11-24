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
                    Label(WordListCategory.allWords.rawValue, systemImage: "list.bullet")
                }
            }
            .frame(minWidth: 224)
            .navigationTitle("Vocabulist")
        } detail: {
            WordTable(words: words.map { $0 })
                .toolbar {
                    ToolbarItem {
                        Button(action: { showAddWordDialog.toggle() }) {
                            Label("Add Word", systemImage: "plus")
                        }
                        .sheet(isPresented: $showAddWordDialog) {
                            AddWordDialog(onAdd: addWord)
                        }
                    }
                }
                .navigationTitle(WordListCategory.allWords.rawValue)
        }
        #if os(macOS)
        .task { selection = .allWords }
        #endif
    }
    
    private func addWord(withForeignName foreignName: String, nativeName: String) {
        withAnimation {
            let newWord = Word(context: viewContext)
            newWord.foreignName = foreignName
            newWord.nativeName = nativeName
            newWord.creationDate = Date()
            newWord.level = 1
            try? viewContext.save()
        }
    }
}
