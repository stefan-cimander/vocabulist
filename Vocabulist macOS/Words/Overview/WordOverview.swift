//
//  WordOverview.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 23.11.22.
//

import SwiftUI

struct WordOverview: View {
    
    let words: [Word]
    let onDelete: (IndexSet) -> Void
    
    private var sortedWords: [Word] {
        words.sorted(using: sortOrder)
    }
    
    @EnvironmentObject private var settingsStore: SettingsStore
    
    @State private var selection = Set<Word.ID>()
    @State private var sortOrder = [KeyPathComparator(\Word.creationDate!)]
    
    var body: some View {
        Table(sortedWords, selection: $selection, sortOrder: $sortOrder) {
            TableColumn(settingsStore.foreignLanguage.localized, value: \.foreignName!).width(min: 140)
            TableColumn(settingsStore.nativeLanguage.localized, value: \.nativeName!).width(min: 140)
            TableColumn("Level", value: \.level.description).width(50)
            TableColumn("Chapter", value: \.chapter!.title!).width(min: 100)
            TableColumn("Created", value: \.creationDate!) { Text($0.creationDate!, formatter: dateFormatter) }.width(min: 100)
        }
        .contextMenu {
            deleteButton
        }
    }
    
    private var deleteButton: some View {
        let offsets = selection.compactMap { id in words.firstIndex(where: { $0.id == id }) }
        let action = { onDelete(IndexSet(offsets)); selection.removeAll() }
        let label = { Label("Delete", systemImage: "trash") }
        return Button(role: .destructive, action: action, label: label).disabled(selection.isEmpty)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
