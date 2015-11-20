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
    
    var quizDataResourcePath : String = "http://tednewardsandbox.site44.com/questions.json";
    
    func loadQuizesWithCompletionHandler(completionHandler: (successful: Bool, dtos: [QuizDataDTO]?) -> Void) {
        let urlToLoad = NSURL(string: quizDataResourcePath);
        if (urlToLoad == nil) {
            return;
        }
        
        let request = NSURLRequest(URL: urlToLoad!);
        let urlSession = NSURLSession.sharedSession();
        
        let task = urlSession.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if (error != nil) {
                    completionHandler(successful: false, dtos: nil);
                } else {
                    do {
                        if (data == nil) {
                            completionHandler(successful: false, dtos: nil);
                            return;
                        }
                        let JSON = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
                        guard let JSONArray :NSArray = JSON as? NSArray else {
                            completionHandler(successful: false, dtos: nil);
                            return;
                        }
                        
                        let quizData = self.parseJSONToQuizData(JSONArray);
                        completionHandler(successful: true, dtos: quizData);
                    }
                    catch {
                        completionHandler(successful: false, dtos: nil);
                    }
                }
            })
        }
        task.resume();
    }
    
    func parseJSONToQuizData(jsonArray : NSArray) -> [QuizDataDTO] {
        var quizDataDTOs : [QuizDataDTO] = [];
        
        for quizData in jsonArray {
            let quizDictionary : NSDictionary = (quizData as? NSDictionary)!;
            
            let questionsArray = (quizDictionary["questions"] as? NSArray)!;
            let questionDTOs = self.parseJSONToQuestionsArray(questionsArray);
            let quizName = (quizDictionary["title"] as? String)!;
            let quizDescription = (quizDictionary["desc"] as? String)!;
            
            let quizDataDTO = QuizDataDTO(quizName: quizName, quizDescription: quizDescription, questions: questionDTOs);
            quizDataDTOs.append(quizDataDTO);
        }
        
        return quizDataDTOs;
    }
    
    func parseJSONToQuestionsArray(questionsArray : NSArray) -> [QuizQuestionDataDTO] {
        var questionDTOs : [QuizQuestionDataDTO] = [];
        
        for questionData in questionsArray {
            let questionDictionary : NSDictionary = (questionData as? NSDictionary)!;
            let questionText = (questionDictionary["text"] as? String)!;
            let answers = (questionDictionary["answers"] as? NSArray)!
            let correctAnswerIndex = (questionDictionary["answer"] as? NSString)!.integerValue;
            
            let questionDataDTO = QuizQuestionDataDTO(questionText: questionText, answerOptions: answers as! [String], correctAnswerIndex: correctAnswerIndex);
            questionDTOs.append(questionDataDTO);
        }
        
        return questionDTOs;
    }
    
}
