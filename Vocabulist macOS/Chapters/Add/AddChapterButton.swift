//
//  AddChapterButton.swift
//  Vocabulist macOS
//
//  Created by Stefan Cimander on 26.11.22.
//

import SwiftUI

struct AddChapterButton: View {
    
    let onAdd: (String) -> Void
    
    @State private var hover = false
    @State private var showAddChapterView = false
    
    var body: some View {
        Button(action: { showAddChapterView.toggle() }) {
            Label("New chapter", systemImage: "plus.circle")
        }
        .opacity(hover ? 1.0 : 0.8)
        .buttonStyle(.plain)
        .onHover { hover = $0 }
        .sheet(isPresented: $showAddChapterView) {
            AddChapterView(onAdd: onAdd)
        }
    }
}

struct AddChapterButton_Previews: PreviewProvider {
    static var previews: some View {
        AddChapterButton() { _ in }
    }
}
