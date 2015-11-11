//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Jacob Alewel on 11/10/15.
//  Copyright © 2015 Jacob Alewel. All rights reserved.
//

import Foundation
import UIKit

class AnswerViewController : UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    private let customNavigationAnimationController = CustomBackAnimationController()
    
    var didAnswerCorrectly : Bool?
    var dataDTO : QuizDataDTO?
    var currentQuestionIndex : Int?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let closeButton = UIBarButtonItem(title: "Close", style: .Done, target: self, action: Selector("closeButtonTapped:"));
        self.navigationItem.setLeftBarButtonItem(closeButton, animated: false);
        
        let nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: Selector("nextButtonTapped:"));
        self.navigationItem.setRightBarButtonItem(nextButton, animated: false);
        
        self.title = "Question \(currentQuestionIndex! + 1)";
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        if (didAnswerCorrectly == true) {
            self.view.backgroundColor = UIColor.greenColor();
        } else {
            self.view.backgroundColor = UIColor.redColor();
        }
        
        let questionDTO = self.dataDTO!.questions[self.currentQuestionIndex!];
        questionLabel.text = questionDTO.questionText;
        answerLabel.text = questionDTO.answerOptions[questionDTO.correctAnswerIndex];
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "NavigateToFinished") {
            let finishedViewController = segue.destinationViewController as! FinishedViewController;
            finishedViewController.dataDTO = self.dataDTO;
        }
    }
    
    // MARK: - Actions
    
    func closeButtonTapped(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
    
    func nextButtonTapped(sender: UIButton) {
        if (self.currentQuestionIndex == dataDTO!.questions.count - 1) {
            performSegueWithIdentifier("NavigateToFinished", sender: nil);
        } else {
            let questionViewController = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-2] as! QuestionTableViewController;
            questionViewController.currentQuestionIndex!++;

            navigationController?.delegate = self;
            self.navigationController!.popViewControllerAnimated(true);
            navigationController?.delegate = nil;
        }
    }
    
    // MARK: - Custom Navigation Animation
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customNavigationAnimationController
    }
    
}