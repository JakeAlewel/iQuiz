//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Jacob Alewel on 11/10/15.
//  Copyright © 2015 Jacob Alewel. All rights reserved.
//

import Foundation
import UIKit

class QuestionTableViewController : UITableViewController {

    var dataDTO : QuizDataDTO?;
    var currentQuestionIndex : Int?;
    
    private var lastSelectedIndexPath : NSIndexPath?;
    
    private let QuestionCellIdentifier = "QuestionCell";
    private let AnswerOptionCellIdentifier = "AnswerOptionCell";
    private static var questionSizingCell : QuestionTableViewCell? = nil;
    private static var answerOptionSizingCell : AnswerOptionTableViewCell? = nil;
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
        self.tableView.tableFooterView = UIView();
        
        self.navigationItem.setHidesBackButton(true, animated: false);
        
        let closeButton = UIBarButtonItem(title: "Close", style: .Done, target: self, action: Selector("closeButtonTapped:"));
        self.navigationItem.setLeftBarButtonItem(closeButton, animated: false);
        
        let submitButton = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: Selector("submitButtonTapped:"));
        self.navigationItem.setRightBarButtonItem(submitButton, animated: false);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        self.title = "Question \(currentQuestionIndex! + 1)";
        self.tableView.reloadData();
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "NavigateToAnswer") {
            let correctAnswerIndex = self.dataDTO!.questions[currentQuestionIndex!].correctAnswerIndex;
            let selectedAnswerIndex = lastSelectedIndexPath!.row - 1;

            let answerViewController = segue.destinationViewController as! AnswerViewController;
            answerViewController.didAnswerCorrectly = (correctAnswerIndex == selectedAnswerIndex);
            answerViewController.dataDTO = self.dataDTO;
            answerViewController.currentQuestionIndex = self.currentQuestionIndex;
        }
    }
    
    // MARK: - Actions
    
    func closeButtonTapped(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
    
    func submitButtonTapped(sender: UIButton) {
        if (lastSelectedIndexPath != nil) {
            performSegueWithIdentifier("NavigateToAnswer", sender: nil);
            lastSelectedIndexPath = nil;
        }
    }
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (lastSelectedIndexPath != nil) {
            tableView.deselectRowAtIndexPath(lastSelectedIndexPath!, animated: true);
        }
        lastSelectedIndexPath = indexPath;
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