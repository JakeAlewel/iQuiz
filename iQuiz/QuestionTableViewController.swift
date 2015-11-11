//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Jacob Alewel on 11/10/15.
//  Copyright © 2015 Jacob Alewel. All rights reserved.
//

import Foundation
import UIKit

let superLongBad = "Super long Test Question Cell to test line wrapping and other super long stuff.";

let QuestionCellIdentifier = "QuestionCell";
let AnswerOptionCellIdentifier = "AnswerOptionCell";

class QuestionTableViewController : UITableViewController {

    var dataDTO : QuizDataDTO?;
    var currentQuestionIndex : Int?;
    
    static var questionSizingCell : QuestionTableViewCell? = nil;
    static var answerOptionSizingCell : AnswerOptionTableViewCell? = nil;
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
        self.tableView.tableFooterView = UIView();
        
        self.navigationItem.setHidesBackButton(true, animated: false);
        
        let barButtonItem = UIBarButtonItem(title: "Close", style: .Done, target: self, action: Selector("closeButtonTapped:"));
        self.navigationItem.setRightBarButtonItem(barButtonItem, animated: false);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        self.title = "Question \(currentQuestionIndex! + 1)";
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "NavigateToAnswer") {
            let answerViewController = segue.destinationViewController as! AnswerViewController;
            answerViewController.didAnswerCorrectly = (sender as! Bool);
        }
    }
    
    // MARK: - Actions
    
    func closeButtonTapped(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        let correctAnswerIndex = self.dataDTO!.questions[currentQuestionIndex!].correctAnswerIndex;
        let selectedAnswerIndex = indexPath.row - 1;
        let didAnswerCorrectly = correctAnswerIndex == selectedAnswerIndex;
        performSegueWithIdentifier("NavigateToAnswer", sender: didAnswerCorrectly);
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    // MARK: - Cell Configuration
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            var cell = tableView.dequeueReusableCellWithIdentifier("QuestionCell");
            if (cell == nil) {
                cell = QuestionTableViewCell();
            }
            
            let questionCell = cell as! QuestionTableViewCell;
            configureQuestionCell(questionCell, forIndexPath: indexPath);
            
            return questionCell;
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("AnswerOptionCell");
            if (cell == nil) {
                cell = AnswerOptionTableViewCell();
            }
            
            let answerCell = cell as! AnswerOptionTableViewCell;
            configureAnswerOptionCell(answerCell, forIndexPath: indexPath);
            return answerCell;
        }

    }
    
    func configureQuestionCell(questionCell : QuestionTableViewCell, forIndexPath indexPath: NSIndexPath) {
        questionCell.questionLabel.text = self.dataDTO!.questions[currentQuestionIndex!].questionText;
    }
    
    func configureAnswerOptionCell(answerOptionCell : AnswerOptionTableViewCell, forIndexPath indexPath: NSIndexPath) {
        answerOptionCell.rowIndicatorLabel.text = "\(indexPath.row))";
        answerOptionCell.answerLabel.text = self.dataDTO!.questions[currentQuestionIndex!].answerOptions[indexPath.row - 1];
    }
    
    // MARK: - Cell Height
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return heightForQuestionCellAtIndexPath(indexPath);
        } else {
            return heightForAnswerOptionCellAtIndexPath(indexPath);
        }
    }

    func heightForQuestionCellAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        if (QuestionTableViewController.questionSizingCell == nil) {
            QuestionTableViewController.questionSizingCell = (self.tableView.dequeueReusableCellWithIdentifier(QuestionCellIdentifier) as! QuestionTableViewCell);
        }
        configureQuestionCell(QuestionTableViewController.questionSizingCell!, forIndexPath: indexPath);
        return calculateHeightForConfiguredSizingCell(QuestionTableViewController.questionSizingCell!);
    }
    
    func heightForAnswerOptionCellAtIndexPath(indexPath : NSIndexPath) -> CGFloat {
        if (QuestionTableViewController.answerOptionSizingCell == nil) {
            QuestionTableViewController.answerOptionSizingCell = (self.tableView.dequeueReusableCellWithIdentifier(AnswerOptionCellIdentifier) as! AnswerOptionTableViewCell);
        }
        configureAnswerOptionCell(QuestionTableViewController.answerOptionSizingCell!, forIndexPath: indexPath);
        return calculateHeightForConfiguredSizingCell(QuestionTableViewController.answerOptionSizingCell!);
    }
    
    func calculateHeightForConfiguredSizingCell(sizingCell : UITableViewCell) -> CGFloat {
        sizingCell.setNeedsLayout();
        sizingCell.layoutIfNeeded();
        
        let size = sizingCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize);
        return size.height + 1.0;
    }
    
}