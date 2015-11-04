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
        
        let quizData = [
            QuizDataDTO(quizName: "Mathematics", quizDescription: "Maths r tght 2 lrn"),
            QuizDataDTO(quizName: "Marvel", quizDescription: "How super is your knowledge on heros?"),
            QuizDataDTO(quizName: "Science", quizDescription: "Time to do some science!")
        ];
        
        completionHandler(successful: true, dtos: quizData);
        
    }
    
}
