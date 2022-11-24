//
//  WordTable.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 23.11.22.
//

import SwiftUI

struct WordTable: View {
    
    var words: [Word]
    
    private var sortedWords: [Word] {
        words.sorted(using: sortOrder)
    }
    
    @State private var selection = Set<Word.ID>()
    @State private var sortOrder = [KeyPathComparator(\Word.creationDate!, order: .reverse)]
    
    var body: some View {
        Table(sortedWords, selection: $selection, sortOrder: $sortOrder) {
            TableColumn("Spanish", value: \.foreignName!)
            TableColumn("German", value: \.nativeName!)
            TableColumn("Created", value: \.creationDate!) { Text($0.creationDate!, formatter: dateFormatter) }
            TableColumn("Level", value: \.level.description).width(min: 50, max: 60)
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
