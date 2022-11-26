//
//  AddWordView.swift
//  Vocabulist iOS
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
        NavigationView {
            Form {
                Section {
                    let foreignLanguage = String(localized: settingsStore.foreignLanguage.localizationValue)
                    let nativeLanguage = String(localized: settingsStore.nativeLanguage.localizationValue)
                    TextField(foreignLanguage, text: $foreignName)
                    TextField(nativeLanguage, text: $nativeName)
                }
                .autocapitalization(.none)
                .disableAutocorrection(true)
            }
            .navigationBarTitle("New word", displayMode: .inline)
            .navigationBarItems(leading: cancelButton, trailing: doneButton)
        }
    }
    
    // MARK: Navigation bar item buttons
    
    private var cancelButton: some View {
        Button("Cancel") { dismiss() }
    }
    
    private var doneButton: some View {
        Button("Add") {
            let addWordInput = AddWordInput(
                foreignName: foreignName.trimmed(),
                nativeName: nativeName.trimmed()
            )
            onAdd(addWordInput)
            dismiss()
        }
        .disabled(foreignName.trimmed().isEmpty || nativeName.trimmed().isEmpty)
        .font(.headline)
    }
}

struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordView() { _ in }
            .environmentObject(SettingsStore())
    }
}
