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
var token: dispatch_once_t = 0;

class QuestionTableViewController : UITableViewController {
    
    static var questionSizingCell : QuestionTableViewCell? = nil;
    static var answerOptionSizingCell : AnswerOptionTableViewCell? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
        self.tableView.tableFooterView = UIView();
        
        self.navigationItem.setHidesBackButton(true, animated: false);
        
        let barButtonItem = UIBarButtonItem(title: "Close", style: .Done, target: self, action: Selector("closeButtonTapped:"));
        self.navigationItem.setRightBarButtonItem(barButtonItem, animated: false);
    }
    
    func closeButtonTapped(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
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
    

    
//    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [self heightForBasicCellAtIndexPath:indexPath];
//    }
//
//    - (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
//    static RWBasicCell *sizingCell = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//    sizingCell = [self.tableView dequeueReusableCellWithIdentifier:RWBasicCellIdentifier];
//    });
//    
//    [self configureBasicCell:sizingCell atIndexPath:indexPath];
//    return [self calculateHeightForConfiguredSizingCell:sizingCell];
//    }
//    
//    - (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
//    [sizingCell setNeedsLayout];
//    [sizingCell layoutIfNeeded];
//    
//    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height + 1.0f; // Add 1.0f for the cell separator height
//    }
    
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
        questionCell.questionLabel.text = superLongBad;
    }

    func configureAnswerOptionCell(answerOptionCell : AnswerOptionTableViewCell, forIndexPath indexPath: NSIndexPath) {
        answerOptionCell.rowIndicatorLabel.text = "\(indexPath.row)";
        answerOptionCell.answerLabel.text = superLongBad;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    
}