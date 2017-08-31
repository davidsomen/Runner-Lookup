//
//  RLFileManager.swift
//  Runner Lookup
//
//  Created by David Somen on 25/08/2015.
//  Copyright (c) 2015 David Somen. All rights reserved.
//

import UIKit

class RLFileManager
{
    private let kFileName = "runnerdata.csv"
    
    let file: String
    let fileManager: FileManager
    
    init()
    {
        fileManager = FileManager.default
        
        let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        file = URL(fileURLWithPath: directory!).appendingPathComponent(kFileName).path
    }
    
    func loadRunners() throws -> [Runner]
    {
        var runners = [Runner]()
        
        if fileManager.fileExists(atPath: file)
        {
            let string = try! String(contentsOfFile: file, encoding: String.Encoding.utf8)
            let array = string.components(separatedBy:"\r\n")
            
            if array.count == 0
            {
                throw RunnerError.noRunnerData
            }
            
            for runnerData in array
            {
                if runnerData == ""
                {
                    continue
                }
                
                let array = runnerData.components(separatedBy:",")
                
                if array[0] == ""
                {
                    continue
                }
            
                if array.count > 4
                {
                    if let number = Int(array[0])
                    {
                        let firstName = capitalizeFirstLetter(string: array[1])
                        let lastName = capitalizeFirstLetter(string: array[2])
                        let name = firstName + " " + lastName
                        
                        let runner = Runner(number: number, name: name, club:array[3], comment: array[4])
                        runners.append(runner)
                    }
                    else
                    {
                        if array[0] != "Number"
                        {
                            throw RunnerError.notNumber
                        }
                    }
                }
                else
                {
                    throw RunnerError.notEnoughData
                }
            }
        }
        else
        {
            throw RunnerError.fileNotFound
        }
        
        return runners
    }
    
    private func capitalizeFirstLetter(string: String) -> String
    {
        let first = String(string.characters.prefix(1)).capitalized
        let other = String(string.characters.dropFirst())
        
        return first + other
    }
}
