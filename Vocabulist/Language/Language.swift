//
//  Language.swift
//  Vocabulist macOS
//
//  Created by Stefan Cimander on 25.11.22.
//

import SwiftUI

enum Language: String, CaseIterable {
    case english
    case french
    case german
    case italian
    case spanish
    
    var localized: LocalizedStringKey {
        LocalizedStringKey(self.rawValue.capitalized)
    }
    
    var localizationValue: String.LocalizationValue {
        String.LocalizationValue(self.rawValue.capitalized)
    }
}
