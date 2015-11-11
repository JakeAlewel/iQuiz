//
//  QuizQuestionDataDTO.swift
//  iQuiz
//
//  Created by Jacob Alewel on 11/10/15.
//  Copyright © 2015 Jacob Alewel. All rights reserved.
//

import Foundation

class QuizQuestionDataDTO {

    let questionText : String;
    let answerOptions : [String];
    let correctAnswerIndex : Int;
    
    init(questionText : String, answerOptions : [String], correctAnswerIndex : Int) {
        self.questionText = questionText;
        self.answerOptions = answerOptions;
        self.correctAnswerIndex = correctAnswerIndex;
    }
    
}