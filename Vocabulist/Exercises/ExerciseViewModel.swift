//
//  ExerciseViewModel.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 03.12.22.
//

import Foundation

class ExerciseViewModel: ObservableObject {
    
    @Published private(set) var words: [Word] = []
    
    private let wordsStore = WordsStore()
    
    func chooseRandomWordsForExercise() {
        wordsStore.loadAllWords()
        let numberOfWords = min(wordsStore.words.count, 10)
        words = Array(wordsStore.words[0..<numberOfWords])
    }
    
}
