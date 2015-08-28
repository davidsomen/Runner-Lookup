//
//  RunnerErrors.swift
//  Runner Lookup
//
//  Created by David Somen on 26/08/2015.
//  Copyright (c) 2015 David Somen. All rights reserved.
//

let RunnerErrorDomain = "com.David-Somen.Runner-Lookup.ErrorDomain"

enum RunnerErrorType: Int
{
    case FileNotFound
    case NoRunnerData
    case NotEnoughData
    case NotNumber
}