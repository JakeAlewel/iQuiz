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
    
    var didAnswerCorrectly : Bool?
    var dataDTO : QuizDataDTO?
    var currentQuestionIndex : Int?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        navigationController?.delegate = self;
        
        let closeButton = UIBarButtonItem(title: "Close", style: .Done, target: self, action: Selector("closeButtonTapped:"));
        self.navigationItem.setLeftBarButtonItem(closeButton, animated: false);
        
        let nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: Selector("nextButtonTapped:"));
        self.navigationItem.setRightBarButtonItem(nextButton, animated: false);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        if (didAnswerCorrectly == true) {
            self.view.backgroundColor = UIColor.greenColor();
        } else {
            self.view.backgroundColor = UIColor.redColor();
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "NavigateBackToFinished") {
            let questionViewController = segue.destinationViewController as! QuestionTableViewController;
            questionViewController.currentQuestionIndex = self.currentQuestionIndex! + 1;
            questionViewController.dataDTO = self.dataDTO;
        }
    }
    
    // MARK: - Actions
    
    func closeButtonTapped(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
    
    func nextButtonTapped(sender: UIButton) {
        if (self.currentQuestionIndex == dataDTO?.questions.count) {
            
        } else {
            
            let questionViewController = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-2] as! QuestionTableViewController;
            questionViewController.currentQuestionIndex!++;
            
            
//            let transition = CATransition();
//            transition.duration = 0.3;
//            transition.type = kCATransitionPush;
//            transition.subtype = kCATransitionFromRight;
//            self.navigationController!.view.layer.addAnimation(transition, forKey: kCATransition);
            self.navigationController!.popViewControllerAnimated(true);
        }
    }
    
    let customNavigationAnimationController = CustomBackAnimationController()
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        customNavigationAnimationController.reverse = operation == .Pop
        return customNavigationAnimationController
    }
    
}