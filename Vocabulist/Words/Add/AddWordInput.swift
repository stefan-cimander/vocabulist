//
//  AddWordInput.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 24.11.22.
//

import Foundation

/// Input provided by the user when adding a new word.
struct AddWordInput {
    
    /// The foreign name of the word to add.
    let foreignName: String
    
    /// The native name of the word to add.
    let nativeName: String
}
