//
//  NavigationWordsView.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 26.11.22.
//

import SwiftUI

struct NavigationWordsView: View {
    
    @State private var selection: NavigationWordsRoute?
    
    var body: some View {
        NavigationSplitView {
            ChaptersList(selection: $selection)
        } detail: {
            let title = selection?.localized ?? ""
            WordsOverview(title: title, chapter: selectedChapter)
        }
        #if os(macOS)
        .task { selection = .allWords }
        #endif
    }
    
    private var selectedChapter: Chapter? {
        switch selection {
        case let .chapter(chapter): return chapter
        default: return nil
        }
    }
}
