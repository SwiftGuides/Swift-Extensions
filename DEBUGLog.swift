//
//  DEBUGLog.swift
//
//  Created by Augus on 2/21/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation

#if DEBUG
    
    func DEBUGLog(_ message: String?, filename: NSString = #file, function: String = #function, line: Int = #line) {
        NSLog("[\(filename.lastPathComponent):\(line)] \(function) - \(message)")
    }
    
    func DEBUGLog(_ message: AnyObject?, filename: NSString = #file, function: String = #function, line: Int = #line) {
        NSLog("[\(filename.lastPathComponent):\(line)] \(function) - \(message)")
    }
    
    func DEBUGPrint(_ any: Any?) {
        print(any)
    }
    
#else
    
    func DEBUGLog(_ message: String?, filename: String = #file, function: String = #function, line: Int = #line) {
    }
    
    func DEBUGLog(_ message: AnyObject?, filename: NSString = #file, function: String = #function, line: Int = #line) {
    }
    
    func DEBUGPrint(_ any: Any?) {
    }
    
#endif
