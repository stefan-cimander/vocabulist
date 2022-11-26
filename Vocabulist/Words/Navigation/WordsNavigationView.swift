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
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Chapter.creationDate, ascending: true)], animation: .default)
    private var chapters: FetchedResults<Chapter>
    
    @State private var selection: WordsRoute?
    @State private var showAddWordDialog = false
    @State private var hoverNewChapterButton = false
    
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
                            Label { Text(chapter.title ?? "") } icon: { Text("\(index + 1)") }
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
            
            #if os(macOS)
            Spacer()
            HStack {
                Button(action: addNewChapter) {
                    Label("Neuer Ordner", systemImage: "plus.circle")
                }
                .opacity(hoverNewChapterButton ? 1.0 : 0.8)
                .buttonStyle(.plain)
                .onHover { hoverNewChapterButton = $0 }
                
                Spacer()
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            #endif
            
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
    
    private func addNewChapter() {
        withAnimation {
            let chapter = Chapter(context: viewContext)
            chapter.title = "Sample Chapter"
            chapter.creationDate = Date()
            try? viewContext.save()
        }
    }
    
    private func addWord(with input: AddWordInput) {
        withAnimation {
            let word = Word(context: viewContext)
            word.foreignName = input.foreignName
            word.nativeName = input.nativeName
            word.creationDate = Date()
            word.level = 1
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
