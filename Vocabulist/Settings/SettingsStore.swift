//
//  SettingsStore.swift
//  Vocabulist macOS
//
//  Created by Stefan Cimander on 25.11.22.
//

import SwiftUI

class SettingsStore: ObservableObject {
    
    @AppStorage("foreignLanguage") var foreignLanguage: Language = .english
    @AppStorage("nativeLanguage") var nativeLanguage: Language = .german
}
