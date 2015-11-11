//
//  QuizTableViewController.swift
//  iQuiz
//
//  Created by Jacob Alewel on 11/3/15.
//  Copyright © 2015 Jacob Alewel. All rights reserved.
//

import Foundation
import UIKit

class QuizTableViewController : UITableViewController {
    
    let dataProxy = QuizDataProxy();
    var dataDtos : [QuizDataDTO]?;
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.tableView.tableFooterView = UIView();

        let barButtonItem = UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("handleSettingsButtonTapped:"));        
        self.navigationItem.setRightBarButtonItem(barButtonItem, animated: false);
    }
    
    override func viewWillAppear(animated: Bool) {
        dataProxy.loadQuizesWithCompletionHandler { (successful, dtos) -> Void in
            if successful {
                self.dataDtos = dtos;
                self.tableView.reloadData();
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "NavigateToQuizQuestion") {
            let firstQuestionViewController = segue.destinationViewController as! QuestionTableViewController;
            let dtoIndex = sender as! Int;
            firstQuestionViewController.dataDTO = self.dataDtos![dtoIndex];
            firstQuestionViewController.currentQuestionIndex = 0;
        }
    }
    
    // MARK: - Actions
    
    func handleSettingsButtonTapped(sender: UIButton) {
        let alertController = UIAlertController(title: "Settings", message: "They Go Here", preferredStyle: UIAlertControllerStyle.Alert);

        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        alertController.addAction(alertAction);
        
        presentViewController(alertController, animated: true, completion: nil);
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        self.performSegueWithIdentifier("NavigateToQuizQuestion", sender: indexPath.row);
    }
    
    // MARK: - UITableView

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataDtos == nil {
            return 0;
        } else {
            return dataDtos!.count;
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170.0;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("QuizCell");
        if (cell == nil) {
            cell = QuizTableViewCell();
        }
        
        let dto = self.dataDtos![indexPath.row];
        
        let quizCell = cell as! QuizTableViewCell;
        quizCell.nameLabel.text = dto.quizName;
        quizCell.descriptionLabel.text = dto.quizDescription;
        return quizCell;
    }
    
}