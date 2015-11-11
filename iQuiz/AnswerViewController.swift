//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Jacob Alewel on 11/10/15.
//  Copyright © 2015 Jacob Alewel. All rights reserved.
//

import Foundation
import UIKit

class AnswerViewController : UIViewController {
    
    var didAnswerCorrectly : Bool?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        if (didAnswerCorrectly == true) {
            self.view.backgroundColor = UIColor.greenColor();
        } else {
            self.view.backgroundColor = UIColor.redColor();
        }
    }
    
}