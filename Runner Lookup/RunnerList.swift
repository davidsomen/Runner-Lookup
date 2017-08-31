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
    fileprivate let _fileManager = RLFileManager()
    fileprivate var _runners = [Runner]()
    
    var total: Int
    {
        get
        {
            return _runners.count
        }
    }
    
    init() throws
    {
        _runners = try _fileManager.loadRunners()
    }
    
    func find(_ number: Int) -> Runner?
    {
        let filteredRunners = _runners.filter({ $0.number == number})
        
        if filteredRunners.count > 0
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
