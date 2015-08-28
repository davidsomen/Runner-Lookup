//
//  RunnerTextField.swift
//  Runner Lookup
//
//  Created by David Somen on 28/08/2015.
//  Copyright (c) 2015 David Somen. All rights reserved.
//

import UIKit

@IBDesignable
class RunnerTextField: UITextField
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height/2 - 3
    }
    
    override func caretRectForPosition(position: UITextPosition!) -> CGRect
    {
        return CGRectZero
    }
}
