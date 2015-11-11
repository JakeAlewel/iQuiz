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

    @IBOutlet weak var resultsDescriptionLabel: UILabel!
    @IBOutlet weak var resultsDataLabel: UILabel!
    
    var dataDTO : QuizDataDTO?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        configureNavigationBar();
        configureDescriptionLabel();
        configureDataLabel();
    }
    
    // MARK: - UI Configuration
    
    func configureNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: false);
        self.title = "Finished!";
    }
    
    func configureDescriptionLabel() {
        let percent = Double(self.dataDTO!.numberOfCorrectAnswers) / Double(self.dataDTO!.questions.count) * 100;
        var descriptionText : String = "Error"
        switch (percent) {
        case 0...20:
            descriptionText = "You're bad"
            break;
        case 20...40:
            descriptionText = "Slow guy.."
            break;
        case 40...60:
            descriptionText = "Meh"
            break;
        case 60...80:
            descriptionText = "Strong"
            break;
        case 80...100:
            descriptionText = "NERD"
            break;
        default:
            break;
        }
        self.resultsDescriptionLabel.text = descriptionText;
    }
    
    func configureDataLabel() {
        self.resultsDataLabel.text = "\(self.dataDTO!.numberOfCorrectAnswers) / \(self.dataDTO!.questions.count)"
    }
    
    // MARK: - Actions
    
    @IBAction func handleDoneButtonPressed(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
}
