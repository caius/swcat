//
//  main.swift
//  swcat
//
//  Created by Caius Durling on 03/06/2014.
//  Copyright (c) 2014 Caius Durling. All rights reserved.
//

// cat(1) (not a full) clone written in swift
//
// Given no arguments, prints stdin to stdout. Given arguments reads them as files, printing content to stdout. Errors on stderr if files not found.
//

import Foundation

// Outputs
let stderr = NSFileHandle.fileHandleWithStandardError()
let stdin = NSFileHandle.fileHandleWithStandardInput()
let stdout = NSFileHandle.fileHandleWithStandardOutput()

// Grab ARGV by getting process arguments and losing $0 from it
var argv = Array(NSProcessInfo.processInfo().arguments.map { $0 as String })
argv.removeAtIndex(0)

if argv.count > 0 {
    // Each argument is a potential filename, output contents if we can, or output error if not
    let fileManager = NSFileManager.defaultManager()
    
    for filename in argv {
        if !fileManager.isReadableFileAtPath(filename) {
            let errorMessage = "swcat: \(filename): No such file or directory\n"
            stderr.writeData(errorMessage.dataUsingEncoding(NSUTF8StringEncoding))
            continue
        }
        
        stdout.writeData(fileManager.contentsAtPath(filename))
    }
} else {
    // Read from stdin
    stdout.writeData(stdin.readDataToEndOfFile())
}
