//
//  ExerciseView.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 03.12.22.
//

import SwiftUI

struct ExerciseView: View {
    
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    
    var body: some View {
        Text("\(exerciseViewModel.words.count) words are ready to repeat.")
            .onAppear(perform: exerciseViewModel.chooseRandomWordsForExercise)
    }
}
