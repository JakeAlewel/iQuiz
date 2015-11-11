//
//  CustomBackSegue.swift
//  iQuiz
//
//  Created by Jacob Alewel on 11/10/15.
//  Copyright © 2015 Jacob Alewel. All rights reserved.
//

import Foundation
import UIKit

class CustomBackAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3;
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
        let containerView : UIView! = transitionContext.containerView()
        
        toViewController.view.frame = finalFrameForVC
        containerView.addSubview(toViewController.view)

        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height

        toViewController.view.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight);
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            toViewController.view.frame = CGRectOffset(toViewController.view.frame, -screenWidth, 0.0);
            toViewController.view.alpha = 1;
        }, completion: {
            finished in
            transitionContext.completeTransition(true);
        });
    }
    
}