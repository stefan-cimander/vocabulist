//
//  AppView.swift
//  Vocabulist iOS
//
//  Created by Stefan Cimander on 23.11.22.
//

import SwiftUI

struct AppView: View {
    
    @State private var selection: AppTab = .words
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationWordsView()
                .tabItem { Label("Vocabulary", systemImage: "book") }
                .tag(AppTab.words)
            ExercisesView()
                .tabItem { Label("Exercises", systemImage: "play") }
                .tag(AppTab.exercises)
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
                .tag(AppTab.profile)
        }
    }
}
