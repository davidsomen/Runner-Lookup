//
//  RunnerManager.swift
//  Runner Lookup
//
//  Created by David Somen on 25/08/2015.
//  Copyright (c) 2015 David Somen. All rights reserved.
//

import UIKit

class RunnerList
{
    private let _fileManager = FileManager()
    private var _runners: [Runner]
    
    var total: Int
    {
        get
        {
            return count(_runners)
        }
    }
    
    init(error: NSErrorPointer)
    {
        _runners = _fileManager.loadRunners(error)
    }
    
    func find(number: Int) -> Runner?
    {
        let filteredRunners = _runners.filter({ $0.number == number})
        
        if count(filteredRunners) > 0
        {
            return filteredRunners.first
        }
        
        return nil
    }
    
    subscript(number: Int) -> Runner
    {
        return _runners[number]
    }
}