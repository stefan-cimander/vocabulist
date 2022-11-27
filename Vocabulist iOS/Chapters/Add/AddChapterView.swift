//
//  AddChapterView.swift
//  Vocabulist iOS
//
//  Created by Stefan Cimander on 26.11.22.
//

import SwiftUI

struct AddChapterView: View {
    
    let onAdd: (String) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                }
                .disableAutocorrection(true)
            }
            .navigationBarTitle("New chapter", displayMode: .inline)
            .navigationBarItems(leading: cancelButton, trailing: doneButton)
        }
    }
    
    // MARK: Navigation bar item buttons
    
    private var cancelButton: some View {
        Button("Cancel") { dismiss() }
    }
    
    private var doneButton: some View {
        Button("Add") {
            onAdd(title.trimmed())
            dismiss()
        }
        .disabled(title.trimmed().isEmpty)
        .font(.headline)
    }
}

struct AddChapterView_Previews: PreviewProvider {
    static var previews: some View {
        AddChapterView() { _ in }
    }
}
