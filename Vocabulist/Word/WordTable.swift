//
//  WordTable.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 23.11.22.
//

import SwiftUI

struct WordTable: View {
    
    var words: [Word]
    
    @State private var selection = Set<Word.ID>()
    
    var body: some View {
        Table(words, selection: $selection) {
            TableColumn("Spanish") { Text($0.foreignName ?? "") }
            TableColumn("German") { Text($0.nativeName ?? "") }
            TableColumn("Level", value: \.level.description).width(min: 50, max: 60)
        }
    }
}
