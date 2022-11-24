//
//  WordListCategory.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 23.11.22.
//

import SwiftUI

enum WordListCategory: String {
    case allWords = "All words"
    
    var localized: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
}
