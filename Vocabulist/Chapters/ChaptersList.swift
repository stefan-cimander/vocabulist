//
//  ChaptersList.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 26.11.22.
//

import SwiftUI

struct ChaptersList: View {
    
    @Binding var selection: NavigationWordsRoute?
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Chapter.creationDate, ascending: true)], animation: .default)
    private var chapters: FetchedResults<Chapter>
    
    @State private var hoverNewChapterButton = false
    
    var body: some View {
        List(selection: $selection) {
            Section {
                NavigationLink(value: NavigationWordsRoute.allWords) {
                    Label(NavigationWordsRoute.allWords.localized, systemImage: "list.bullet")
                }
            }
            Section("Chapters") {
                ForEach(chapters.indices, id: \.self) { index in
                    let chapter = chapters[index]
                    NavigationLink(value: NavigationWordsRoute.chapter(chapter)) {
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
                Label("New chapter", systemImage: "plus.circle")
            }
            .opacity(hoverNewChapterButton ? 1.0 : 0.8)
            .buttonStyle(.plain)
            .onHover { hoverNewChapterButton = $0 }
            
            Spacer()
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
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
}
