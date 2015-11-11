//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Jacob Alewel on 11/10/15.
//  Copyright © 2015 Jacob Alewel. All rights reserved.
//

import Foundation
import UIKit

class FinishedViewController: UIViewController {

    var dataDTO : QuizDataDTO?
    
    
    @IBOutlet weak var resultsDescriptionLabel: UILabel!
    
    @IBOutlet weak var resultsDataLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.navigationItem.setHidesBackButton(true, animated: false);
        
        self.title = "Finished!";
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        
    }
    
    @IBAction func handleDoneButtonPressed(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
}
