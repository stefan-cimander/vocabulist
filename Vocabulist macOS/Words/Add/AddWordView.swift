//
//  AddWordView.swift
//  Vocabulist macOS
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
        HStack {
            Text("New word")
                .font(.headline)
            Spacer()
        }
        .padding(.leading, 20)
        .padding(.top)
        
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
        .toolbar { toolbar }
    }
    
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Add", action: addWord)
                .disabled(!isValidWord)
        }
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", action: dismiss.callAsFunction)
        }
    }
    
    private var isValidWord: Bool {
        !foreignName.trimmed().isEmpty && !nativeName.trimmed().isEmpty
    }
    
    private func addWord() {
        guard isValidWord else { return }
        withAnimation {
            let addWordInput = AddWordInput(
                foreignName: foreignName.trimmed(),
                nativeName: nativeName.trimmed()
            )
            wordsStore.addWord(with: addWordInput, to: chapter)
            dismiss()
        }
    }
}
