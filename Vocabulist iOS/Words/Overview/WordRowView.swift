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

struct WordRowView_Previews: PreviewProvider {
    static var context = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        let word = Word(context: context)
        word.foreignName = "el arbol"
        word.nativeName = "der Baum"
        return WordRowView(word: word)
    }
}
