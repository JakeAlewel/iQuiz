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
            QuizDataDTO(quizName: "Marvel", quizDescription: "Super Heros")
        ];
        
        completionHandler(successful: true, dtos: quizData);
        
    }
    
}
