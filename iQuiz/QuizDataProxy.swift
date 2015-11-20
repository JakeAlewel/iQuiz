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
    
    static var CacheKey = "CacheKeyFor_iQuiz"
    
    var quizDataResourcePath : String = "http://tednewardsandbox.site44.com/questions.json";
    
    func loadQuizesWithCompletionHandler(completionHandler: (fromCache: Bool, dtos: [QuizDataDTO]?) -> Void) {
        let urlToLoad = NSURL(string: quizDataResourcePath);
        if (urlToLoad == nil) {
            return;
        }
        
        let request = NSURLRequest(URL: urlToLoad!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60);
        let urlSession = NSURLSession.sharedSession();
        
        let task = urlSession.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if (error != nil) {
                    self.attemptToRecoverFromCache(completionHandler);
                } else {
                    if (data == nil) {
                        self.attemptToRecoverFromCache(completionHandler);
                    } else {
                        let parsedQuizData : [QuizDataDTO]? = self.parseJsonData(data!);
                        completionHandler(fromCache: false, dtos: parsedQuizData);
                    }
                }
            })
        }
        task.resume();
    }
    
    // MARK: - Error Handling
    
    func attemptToRecoverFromCache(completionHandler: (fromCache: Bool, dtos: [QuizDataDTO]?) -> Void) {
        let quizData = NSUserDefaults.standardUserDefaults().objectForKey(QuizDataProxy.CacheKey) as? NSData;
        if (quizData != nil) {
            let parsedQuizData : [QuizDataDTO]? = self.parseJsonData(quizData!);
            completionHandler(fromCache: true, dtos: parsedQuizData);
        } else {
            completionHandler(fromCache: true, dtos: nil);
        }
    }
    
    // MARK: - JSON Parsing
    
    func parseJsonData(jsonData: NSData) -> [QuizDataDTO]? {
        do {
            let JSON = try NSJSONSerialization.JSONObjectWithData(jsonData, options:NSJSONReadingOptions.AllowFragments)
            guard let JSONArray :NSArray = JSON as? NSArray else {
                return nil;
            }
            
            let quizData = self.parseQuizData(JSONArray);
            NSUserDefaults.standardUserDefaults().setObject(jsonData, forKey: QuizDataProxy.CacheKey);
            return quizData;
        } catch {
            return nil;
        }
    }
    
    func parseQuizData(jsonArray : NSArray) -> [QuizDataDTO] {
        var quizDataDTOs : [QuizDataDTO] = [];
        
        for quizData in jsonArray {
            let quizDictionary : NSDictionary = (quizData as? NSDictionary)!;
            
            let questionsArray = (quizDictionary["questions"] as? NSArray)!;
            let questionDTOs = self.parseQuestionsData(questionsArray);
            let quizName = (quizDictionary["title"] as? String)!;
            let quizDescription = (quizDictionary["desc"] as? String)!;
            
            let quizDataDTO = QuizDataDTO(quizName: quizName, quizDescription: quizDescription, questions: questionDTOs);
            quizDataDTOs.append(quizDataDTO);
        }
        
        return quizDataDTOs;
    }
    
    func parseQuestionsData(questionsArray : NSArray) -> [QuizQuestionDataDTO] {
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
