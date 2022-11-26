//
//  WordsRoute.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 23.11.22.
//

import SwiftUI

enum WordsRoute: Equatable, Hashable {
    case allWords
    case chapter(_ value: Chapter)
    
    var localized: String {
        switch self {
        case .allWords: return String(localized: "All words")
        case .chapter(let chapter): return chapter.title
        }
    }
}
