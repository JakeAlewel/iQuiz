//
//  QuizDataProxy.swift
//  iQuiz
//
//  Created by Jacob Alewel on 11/3/15.
//  Copyright © 2015 Jacob Alewel. All rights reserved.
//

import Foundation
import UIKit

class QuizDataProxy {
    
    func loadQuizesWithCompletionHandler(completionHandler: (successful: Bool, dtos: [QuizDataDTO]) -> Void) {
        
        let answerOptions = [
            "1",
            "2",
            "3",
            "4"
        ];
        
        let questionDTOs = [
            QuizQuestionDataDTO(questionText: "2 + 2 = ?", answerOptions: answerOptions, correctAnswerIndex: 3),
            QuizQuestionDataDTO(questionText: "1 + 1 = ?", answerOptions: answerOptions, correctAnswerIndex: 1),
            QuizQuestionDataDTO(questionText: "3 - 2 = ?", answerOptions: answerOptions, correctAnswerIndex: 0),
            QuizQuestionDataDTO(questionText: "4 - 1 = ?", answerOptions: answerOptions, correctAnswerIndex: 2)
        ];
        
        let quizData = [
            QuizDataDTO(quizName: "Mathematics", quizDescription: "Maths r tght 2 lrn", questions: questionDTOs),
            QuizDataDTO(quizName: "Marvel", quizDescription: "How super is your knowledge on heros?", questions: questionDTOs),
            QuizDataDTO(quizName: "Science", quizDescription: "Time to do some science!", questions: questionDTOs)
        ];
        
        completionHandler(successful: true, dtos: quizData);
        
    }
    
}
