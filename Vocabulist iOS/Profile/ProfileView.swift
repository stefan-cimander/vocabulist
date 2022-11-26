//
//  ProfileView.swift
//  Vocabulist iOS
//
//  Created by Stefan Cimander on 26.11.22.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var settingsStore: SettingsStore
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Language Settings") {
                    Picker("Foreign Language", selection: settingsStore.$foreignLanguage) {
                        ForEach(Language.allCases, id: \.self) { language in
                            Text(language.localized)
                        }
                    }
                    Picker("Native Language", selection: settingsStore.$nativeLanguage) {
                        ForEach(Language.allCases, id: \.self) { language in
                            Text(language.localized)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SettingsStore())
    }
}
