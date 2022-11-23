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

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                NavigationLink(value: WordListCategory.allWords) {
                    Label("All Words", systemImage: "list.bullet")
                }
            }
        } detail: {
            WordTable(words: words.map { $0 })
                .toolbar {
                    ToolbarItem {
                        Button(action: addWord) {
                            Label("Add Word", systemImage: "plus")
                        }
                    }
                }
        }
        .navigationDestination(for: WordListCategory.self) { category in
            WordTable(words: words.map { $0 })
        }
    }
    
    private func addWord() {
        withAnimation {
            let newWord = Word(context: viewContext)
            newWord.nativeName = "bauen"
            newWord.foreignName = "construir"
            newWord.level = 1
            newWord.creationDate = Date()
            
            try? viewContext.save()
        }
    }
}
