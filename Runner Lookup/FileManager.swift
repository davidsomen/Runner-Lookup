//
//  RunnerFileManager.swift
//  Runner Lookup
//
//  Created by David Somen on 25/08/2015.
//  Copyright (c) 2015 David Somen. All rights reserved.
//

import UIKit

class FileManager
{
    private let kFileName = "runners.csv"
    
    let file: String
    let fileManager: NSFileManager
    
    init()
    {
        fileManager = NSFileManager.defaultManager()
        
        let directory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as! String
        file = directory.stringByAppendingPathComponent(kFileName)
    }
    
    func loadRunners(error: NSErrorPointer) -> [Runner]
    {
        var runners = [Runner]()
        
        if fileManager.fileExistsAtPath(file)
        {
            let string = String(contentsOfFile: file, encoding: NSUTF8StringEncoding, error: nil)
            let array = string!.componentsSeparatedByString("\r\n")
            
            if count(array) == 0
            {
                error.memory = NSError(
                    domain: RunnerErrorDomain,
                    code: RunnerErrorType.NoRunnerData.rawValue,
                    userInfo:[NSLocalizedDescriptionKey : "The CSV file contains no runner data"]
                )
            }
            
            for runnerData in array
            {
                if runnerData == ""
                {
                    continue
                }
                
                let array = runnerData.componentsSeparatedByString(",")
                
                if count(array) == 3
                {
                    if let number = array[0].toInt()
                    {
                        let name = array[1]
                        let club = array[2]
                        
                        let runner = Runner(number:number, name:name, club:club)
                        runners.append(runner)
                    }
                    else
                    {
                        if array[0] != "Number"
                        {
                            error.memory = NSError(
                                domain: RunnerErrorDomain,
                                code: RunnerErrorType.NotNumber.rawValue,
                                userInfo:[NSLocalizedDescriptionKey : "The CSV file contains a runner with an invalid number"]
                            )
                        }
                    }
                }
                else
                {
                    error.memory = NSError(
                        domain: RunnerErrorDomain,
                        code: RunnerErrorType.NotEnoughData.rawValue,
                        userInfo:[NSLocalizedDescriptionKey : "The CSV file does not contain enough data per runner"]
                    )
                }
            }
        }
        else
        {
            error.memory = NSError(
                domain: RunnerErrorDomain,
                code: RunnerErrorType.FileNotFound.rawValue,
                userInfo:[NSLocalizedDescriptionKey : "The file \"runners.csv\" was not found in the documents directory"]
            )
        }
        
        return runners
    }
}
