//
//  RunnerTableViewController.swift
//  Runner Lookup
//
//  Created by David Somen on 27/08/2015.
//  Copyright (c) 2015 David Somen. All rights reserved.
//

import UIKit

class RunnerTableViewCell: UITableViewCell
{
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var clubLabel: UILabel!
}

class RunnerTableViewController: UITableViewController
{
    var runnerList: RunnerList!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Runners (\(runnerList.total))"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return runnerList.total
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let runner = runnerList[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! RunnerTableViewCell
        cell.numberLabel.text = String(runner.number)
        cell.nameLabel.text = runner.name
        cell.clubLabel.text = runner.club
        
        return cell
    }
    
    @IBAction func doneButtonPressed()
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
