//
//  QuizDataDTO.swift
//  iQuiz
//
//  Created by Jacob Alewel on 11/3/15.
//  Copyright © 2015 Jacob Alewel. All rights reserved.
//

import Foundation

class QuizDataDTO {
    
    let quizName: String;
    let quizDescription: String;
    let questions: [QuizQuestionDataDTO];
    var numberOfCorrectAnswers : Int = 0;
    
    init(quizName: String, quizDescription: String, questions: [QuizQuestionDataDTO]) {
        self.quizName = quizName;
        self.quizDescription = quizDescription;
        self.questions = questions;
    }
    
}