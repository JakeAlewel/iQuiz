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
        super.viewWillAppear(animated);
        
        self.loadData();
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "NavigateToQuizQuestion") {
            let firstQuestionViewController = segue.destinationViewController as! QuestionTableViewController;
            let dtoIndex = sender as! Int;
            firstQuestionViewController.dataDTO = self.dataDtos![dtoIndex];
            firstQuestionViewController.currentQuestionIndex = 0;
        }
    }
    
    // MARK: - Data
    
    func loadData() {
        dataProxy.loadQuizesWithCompletionHandler { (successful, dtos) -> Void in
            if dtos != nil {
                self.dataDtos = dtos;
                self.tableView.reloadData();
            } else {
                self.presentNetworkErrorAlert();
            }
        }
    }
    
    // MARK: - Actions
    
    func handleSettingsButtonTapped(sender: UIButton) {
        self.presentSettingsAlert();
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
    
    // Mark: Alerts
    
    func presentNetworkErrorAlert() {
        let alertController = UIAlertController(title: "Oh No!", message: "Something went wrong with your network, how sad...", preferredStyle: UIAlertControllerStyle.Alert);
        
        let retryAction = UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.loadData();
        }
        let alertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil);
        
        alertController.addAction(retryAction);
        alertController.addAction(alertAction);
        
        self.presentViewController(alertController, animated: true, completion: nil);
    }
    
    func presentSettingsAlert() {
        let alertController = UIAlertController(title: "Settings", message: "They Go Here", preferredStyle: UIAlertControllerStyle.Alert);
        
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        alertController.addAction(alertAction);
        
        self.presentViewController(alertController, animated: true, completion: nil);
    }
    
}