//
//  TriviaQuestion.swift
//  TriviaBoi
//
//  Created by Kirk Brown on 10/19/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import Foundation

class TriviaQuestion {
    // String storing the text of the question
    let question: String
    
    // string storing the array of possible answers
    let answers: [String]
    
    // Integer to store the index of the correct answer in our answer array
    let correctAnswerIndex: Int
    
    // Computed property that returns the correct answer using the answer index
    var correctAnswer: String {
        return answers[correctAnswerIndex]
    }
    init(question: String, answers: [String], correctAnswerIndex: Int) {
    self.question = question
    self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
}
