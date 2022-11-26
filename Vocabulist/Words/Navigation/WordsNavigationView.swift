//
//  WordsNavigationView.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 26.11.22.
//

import SwiftUI

struct WordsNavigationView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Word.creationDate, ascending: true)], animation: .default)
    private var words: FetchedResults<Word>
    
    private var chapters = [
        Chapter(title: "La magia de Sevilla"),
        Chapter(title: "Regalo de Reyes"),
        Chapter(title: "A medias"),
        Chapter(title: "Una Nochevieja inesperada"),
        Chapter(title: "Papel en blanco"),
        Chapter(title: "Por una vez, algo diferente"),
        Chapter(title: "Ciento cuarenta"),
        Chapter(title: "La torre"),
        Chapter(title: "Un golpe de suerte"),
        Chapter(title: "La rana de la suerte"),
    ]
    
    @State private var selection: WordsRoute?
    @State private var showAddWordDialog = false
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section {
                    NavigationLink(value: WordsRoute.allWords) {
                        Label(WordsRoute.allWords.localized, systemImage: "list.bullet")
                    }
                }
                Section("Chapters") {
                    ForEach(chapters.indices, id: \.self) { index in
                        let chapter = chapters[index]
                        NavigationLink(value: WordsRoute.chapter(chapter)) {
                            Label { Text(chapter.title) } icon: { Text("\(index + 1)") }
                        }
                    }
                }
            }
            #if os(iOS)
            .listStyle(.insetGrouped)
            #endif
            .frame(minWidth: 224)
            .environment(\.defaultMinListRowHeight, 52)
            .navigationTitle("Vocabulary")
        } detail: {
            WordOverview(words: words.map { $0 }, onDelete: deleteWords)
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
                .navigationTitle(selection?.localized ?? "")
                #endif
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
    
    private func deleteWords(at offsets: IndexSet) {
        withAnimation {
            offsets.map { words[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}
