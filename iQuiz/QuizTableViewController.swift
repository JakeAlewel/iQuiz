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
    
    override func viewWillAppear(animated: Bool) {
        dataProxy.loadQuizesWithCompletionHandler { (successful, dtos) -> Void in
            if successful {
                self.dataDtos = dtos;
                self.tableView.reloadData();
            }
        }
    }

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