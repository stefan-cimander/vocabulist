//
//  WordOverview.swift
//  Vocabulist iOS
//
//  Created by Stefan Cimander on 25.11.22.
//

import SwiftUI

struct WordOverview: View {
    
    let words: [Word]
    
    var body: some View {
        List(words) { word in
            WordRowView(word: word)
        }
    }
}

struct WordOverview_Previews: PreviewProvider {
    static var previews: some View {
        WordOverview(words: [])
    }
}
