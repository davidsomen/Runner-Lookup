//
//  ViewController.swift
//  Runner Lookup
//
//  Created by David Somen on 25/08/2015.
//  Copyright (c) 2015 David Somen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    private let kPrimaryColour = UIColor(red:0.0, green:0.63, blue:0.75, alpha:1.0)
    private let kNotFoundColour = UIColor.redColor()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var clubLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var runnerList: RunnerList!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupView()
        loadRunnerList()
    }
    
    func setupView()
    {
        //textField.inputAccessoryView = toolbar
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    func loadRunnerList()
    {
        var error: NSError?
        
        runnerList = RunnerList(error: &error)
        
        if let error = error
        {
            //showError(error)
        }
        else
        {
            //showImportMessage()
            
            clear()
        }
        
        infoLabel.text = String(runnerList.total) + " RUNNERS LOADED"
    }
    
    /*
    func showError(error: NSError)
    {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showImportMessage()
    {
        let message = String(runnerList.total) + " runners have been loaded"
        let alert = UIAlertController(title: "File Load Succesful", message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default)
        {
            alert in
            
            self.clear()
            self.textField.becomeFirstResponder()
        }
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    */

    /*
    @IBAction func nextButtonPressed()
    {
        textField.text = ""
        clear()
    }
    */
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        let numberCharacterSet = NSCharacterSet(charactersInString: "0123456789")
        let textCharacterSet = NSCharacterSet(charactersInString: string)
        
        let isNumber = numberCharacterSet.isSupersetOfSet(textCharacterSet);
        
        if string == ""
        {
            textField.text = ""
            clear()
        }
        
        return isNumber && count(textField.text) < 4
    }
    
    @IBAction func textFieldChanged()
    {
        if let number = textField.text.toInt()
        {
            if let runner = runnerList.find(number)
            {
                nameLabel.text = runner.name
                nameLabel.textColor = kPrimaryColour
                
                clubLabel.text = runner.club
                
                return
            }
        }
        
        clear()
    }
    
    private func clear()
    {
        if count(textField.text) > 0
        {
            nameLabel.text = "No runner found"
            nameLabel.textColor = kNotFoundColour
        }
        else
        {
            nameLabel.text = "Lookup runner number"
            nameLabel.textColor = kPrimaryColour
        }
        
        clubLabel.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let navController = segue.destinationViewController as! UINavigationController
        let viewController = navController.viewControllers.first as! RunnerTableViewController
        viewController.runnerList = runnerList
    }
}
