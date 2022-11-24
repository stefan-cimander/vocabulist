//
//  AddWordDialog.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 24.11.22.
//

import SwiftUI

struct AddWordDialog: View {
    
    var onAdd: (String, String) -> ()
    
    @Environment(\.dismiss) var dismiss

    @State private var foreignName = ""
    @State private var nativeName = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Spanish", text: $foreignName)
                TextField("German", text: $nativeName)
            }
            .padding(4)
        }
        .padding()
        .frame(width: 320)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    onAdd(foreignName, nativeName)
                    dismiss()
                }
            }
        }
    }
}
