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
        dataProxy.loadQuizesWithCompletionHandler { (fromCache, dtos) -> Void in
            if dtos != nil {
                if fromCache {
                    self.presentNetworkErrorAlert("We could not load data from the server, falling back on cache");
                }
                self.dataDtos = dtos;
                self.tableView.reloadData();
            } else {
                if fromCache {
                    self.presentNetworkErrorAlert("We could not load data from the server, and could not load from cache");
                } else {
                    self.presentNetworkErrorAlert("We could not load data from the server");
                }
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
    
    func presentNetworkErrorAlert(errorMessage : String) {
        let alertController = UIAlertController(title: "Oh No!", message: "Something went wrong! \(errorMessage)... how sad.", preferredStyle: UIAlertControllerStyle.Alert);
        
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
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.text = self.dataProxy.quizDataResourcePath;
        }
        
        let alertAction = UIAlertAction(title: "Check Now", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let urlTextField = alertController.textFields![0] as UITextField
                self.dataProxy.quizDataResourcePath = urlTextField.text!;
                self.loadData();
            })
        }
        alertController.addAction(alertAction);
        
        self.presentViewController(alertController, animated: true, completion: nil);
    }
    
}