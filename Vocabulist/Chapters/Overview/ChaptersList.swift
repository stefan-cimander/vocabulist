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
    
    @State private var showAddChapterView = false
    @State private var chapterToEdit: Chapter?
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
                        #if os(iOS)
                        .contextMenu {
                            editButton(for: chapter)
                        }
                        
                        #endif
                    }
                }
                .sheet(isPresented: .init(get: {
                    chapterToEdit != nil
                }, set: { isPresented in
                    guard !isPresented else { return }
                    chapterToEdit = nil
                })) {
                    EditChapterView(chapter: chapterToEdit!, onEdit: editChapter)
                }
            }
        }
        .frame(minWidth: 224)
        .environment(\.defaultMinListRowHeight, 52)
        .navigationTitle("Vocabulary")
        #if os(iOS)
        .listStyle(.insetGrouped)
        .toolbar {
            ToolbarItem {
                Button("New chapter") {
                    showAddChapterView.toggle()
                }
                .sheet(isPresented: $showAddChapterView) {
                    AddChapterView(onAdd: addChapter)
                }
            }
        }
        #endif
        
        #if os(macOS)
        Spacer()
        HStack {
            AddChapterButton(hover: $hoverNewChapterButton, onAdd: addNewChapter)
            Spacer()
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        #endif
    }
    
    private func editButton(for chapter: Chapter) -> some View {
        let action = { chapterToEdit = chapter }
        let label = { Label("Rename", systemImage: "pencil") }
        return Button(action: action, label: label)
    }
    
    private func addChapter(with title: String) {
        withAnimation {
            let chapter = Chapter(context: viewContext)
            chapter.title = title
            chapter.creationDate = Date()
            try? viewContext.save()
        }
    }
    
    private func editChapter(_ chapter: Chapter, withTitle title: String) {
        withAnimation {
            chapter.title = title
            try? viewContext.save()
        }
    }
}
