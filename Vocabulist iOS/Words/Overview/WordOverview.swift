//
//  WordOverview.swift
//  Vocabulist iOS
//
//  Created by Stefan Cimander on 25.11.22.
//

import SwiftUI

struct WordOverview: View {
    let words: [Word]
    let onDelete: (IndexSet) -> Void
    
    var body: some View {
        List {
            ForEach(words) { word in
                WordRowView(word: word)
                    .contextMenu {
                        deleteButton(word)
                    }
            }
            .onDelete(perform: onDelete)
        }
    }
    
    private func deleteButton(_ word: Word) -> some View {
        let index = words.firstIndex(where: { $0.id == word.id })!
        let action = { onDelete(IndexSet(arrayLiteral: index)) }
        let label = { Label("Delete", systemImage: "trash") }
        return Button(role: .destructive, action: action, label: label)
    }
}

struct WordOverview_Previews: PreviewProvider {
    static var previews: some View {
        WordOverview(words: []) { _ in }
    }
}
