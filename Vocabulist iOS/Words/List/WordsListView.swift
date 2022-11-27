//
//  WordsListView.swift
//  Vocabulist iOS
//
//  Created by Stefan Cimander on 25.11.22.
//

import SwiftUI

struct WordsListView: View {
    
    let words: [Word]
    
    @EnvironmentObject private var wordsStore: WordsStore
    
    var body: some View {
        List {
            ForEach(words) { word in
                WordRowView(word: word)
                    .contextMenu {
                        deleteButton(word)
                    }
            }
            .onDelete(perform: deleteWords)
        }
    }
    
    private func deleteButton(_ word: Word) -> some View {
        let index = words.firstIndex(where: { $0.id == word.id })!
        let action = { deleteWords(at: IndexSet(arrayLiteral: index)) }
        let label = { Label("Delete", systemImage: "trash") }
        return Button(role: .destructive, action: action, label: label)
    }
    
    private func deleteWords(at offsets: IndexSet) {
        withAnimation {
            let wordsToDelete = offsets.map { index in words[index] }
            wordsStore.deleteWords(wordsToDelete)
        }
    }
}

struct WordsListViewPreviews: PreviewProvider {
    static var previews: some View {
        WordsListView(words: [])
    }
}
