//
//  WordRowView.swift
//  Vocabulist iOS
//
//  Created by Stefan Cimander on 25.11.22.
//

import SwiftUI

struct WordRowView: View {
    let word: Word
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(word.foreignName ?? "")
                .font(.headline)
                .lineLimit(1)
            Text(word.nativeName ?? "")
                .fontWeight(.light)
        }
    }
}
