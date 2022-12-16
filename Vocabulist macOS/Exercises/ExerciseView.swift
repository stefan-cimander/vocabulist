//
//  ExerciseView.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 03.12.22.
//

import SwiftUI

struct ExerciseView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    
    var body: some View {
        HStack {
            Text("New exercise")
                .font(.headline)
            Spacer()
        }
        .padding(.leading, 20)
        .padding(.top)
        
        Form {
            Text("\(exerciseViewModel.words.count) words are ready to repeat.")
                .onAppear(perform: exerciseViewModel.chooseRandomWordsForExercise)
        }
        .padding()
        .frame(width: 320, height: 180)
        .toolbar { toolbar }
        
    }
    
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Start", action: { })
        }
        ToolbarItem(placement: .automatic) {
            Button("Cancel", action: dismiss.callAsFunction)
        }
    }
}
