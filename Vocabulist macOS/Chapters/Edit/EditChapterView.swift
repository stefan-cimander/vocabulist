//
//  EditChapterView.swift
//  Vocabulist macOS
//
//  Created by Stefan Cimander on 29.11.22.
//

import SwiftUI

struct EditChapterView: View {
    
    let chapter: Chapter
    let onEdit: (Chapter, String) -> Void
    
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    
    var body: some View {
        HStack {
            Text("Rename chapter")
                .font(.headline)
            Spacer()
        }
        .padding(.leading, 20)
        .padding(.top)
        
        Form {
            Section {
                TextField("\(String(localized: "Title")):", text: $title)
            }
            .padding(4)
        }
        .padding()
        .frame(width: 320)
        .toolbar {
            ToolbarItem(placement: .primaryAction, content: addButton)
            ToolbarItem(placement: .cancellationAction, content: cancelButton)
        }
        .onAppear {
            title = chapter.title!
        }
    }
    
    // MARK: Toolbar item buttons
    
    private func addButton() -> some View {
        Button("Done") {
            onEdit(chapter, title.trimmed())
            dismiss()
        }
        .disabled(title.trimmed().isEmpty)
    }
    
    private func cancelButton() -> some View {
        Button("Cancel") {
            dismiss()
        }
    }

}
