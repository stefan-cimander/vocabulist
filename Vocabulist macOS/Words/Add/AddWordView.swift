//
//  AddWordView.swift
//  Vocabulist macOS
//
//  Created by Stefan Cimander on 24.11.22.
//

import SwiftUI

struct AddWordView: View {
    
    let onAdd: (AddWordInput) -> Void
    
    @EnvironmentObject private var settingsStore: SettingsStore
    @Environment(\.dismiss) private var dismiss

    @State private var foreignName = ""
    @State private var nativeName = ""
    
    var body: some View {
        Form {
            Section {
                let foreignLanguage = String(localized: settingsStore.foreignLanguage.localizationValue)
                let nativeLanguage = String(localized: settingsStore.nativeLanguage.localizationValue)
                TextField("\(foreignLanguage):", text: $foreignName)
                TextField("\(nativeLanguage):", text: $nativeName)
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
            let addWordInput = AddWordInput(
                foreignName: foreignName.trimmed(),
                nativeName: nativeName.trimmed()
            )
            onAdd(addWordInput)
            dismiss()
        }
        .disabled(foreignName.trimmed().isEmpty || nativeName.trimmed().isEmpty)
    }
    
    private func cancelButton() -> some View {
        Button("Cancel") {
            dismiss()
        }
    }
}
