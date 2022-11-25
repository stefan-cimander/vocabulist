//
//  SettingsView.swift
//  Vocabulist macOS
//
//  Created by Stefan Cimander on 25.11.22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var settingsStore: SettingsStore
    
    var body: some View {
        TabView {
            Form {
                Picker("\(String(localized: "Foreign Language")):", selection: settingsStore.$foreignLanguage) {
                    ForEach(Language.allCases, id: \.self) { language in
                        Text(language.localized)
                    }
                }
                Picker("\(String(localized: "Native Language")):", selection: settingsStore.$nativeLanguage) {
                    ForEach(Language.allCases, id: \.self) { language in
                        Text(language.localized)
                    }
                }
            }
            .tabItem {
                Label("General", systemImage: "gear")
            }
            .tag(SettingsTab.general)
        }
        .padding()
        .frame(width: 400, height: 100)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
