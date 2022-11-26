//
//  AddChapterView.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 26.11.22.
//

import SwiftUI

struct AddChapterView: View {
    
    let onAdd: (String) -> Void
    
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    
    var body: some View {
        HStack {
            Text("New chapter")
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
    }
    
    // MARK: Toolbar item buttons
    
    private func addButton() -> some View {
        Button("Add") {
            onAdd(title.trimmed())
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

struct AddChapterView_Previews: PreviewProvider {
    static var previews: some View {
        AddChapterView() { _ in }
    }
}
