//
//  EditChapterView.swift
//  Vocabulist iOS
//
//  Created by Stefan Cimander on 27.11.22.
//

import SwiftUI

struct EditChapterView: View {
    
    let chapter: Chapter
    let onEdit: (Chapter, String) -> Void
    
    @State private var title = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                }
                .disableAutocorrection(true)
            }
            .navigationBarTitle("Rename chapter", displayMode: .inline)
            .navigationBarItems(leading: cancelButton, trailing: doneButton)
        }
        .onAppear {
            title = chapter.title!
        }
    }
    
    // MARK: Navigation bar item buttons
    
    private var cancelButton: some View {
        Button("Cancel") { dismiss() }
    }
    
    private var doneButton: some View {
        Button("Done") {
            onEdit(chapter, title.trimmed())
            dismiss()
        }
        .disabled(title.trimmed().isEmpty)
        .font(.headline)
    }
}
