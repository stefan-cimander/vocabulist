//
//  AddWordView.swift
//  Vocabulist iOS
//
//  Created by Stefan Cimander on 24.11.22.
//

import SwiftUI

struct AddWordView: View {
    
    let chapter: Chapter
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var settingsStore: SettingsStore
    @EnvironmentObject private var wordsStore: WordsStore
    
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
            .navigationBarItems(leading: Button("Cancel", action: dismiss.callAsFunction),
                                trailing: Button("Add", action: addWord).disabled(!isValidWord).font(.headline))
        }
    }
    
    private var isValidWord: Bool {
        !foreignName.trimmed().isEmpty && !nativeName.trimmed().isEmpty
    }
    
    private func addWord() {
        guard isValidWord else { return }
        let addWordInput = AddWordInput(
            foreignName: foreignName.trimmed(),
            nativeName: nativeName.trimmed()
        )
        wordsStore.addWord(with: addWordInput, to: chapter)
        dismiss()
    }
}
