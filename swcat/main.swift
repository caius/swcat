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
let stderr = FileHandle.withStandardError
let stdin = FileHandle.withStandardInput
let stdout = FileHandle.withStandardOutput

// Grab ARGV by getting process arguments and losing $0 from it
var argv = Array(ProcessInfo.processInfo.arguments.map { $0 as String })
argv.remove(at: 0)

if argv.count > 0 {
    // Each argument is a potential filename, output contents if we can, or output error if not
    let fileManager = FileManager.default
    
    for filename in argv {
        if !fileManager.isReadableFile(atPath: filename) {
            let errorMessage = "cat: \(filename): No such file or directory\n"
            stderr.write(errorMessage.data(using: String.Encoding.utf8)!)
            continue
        }
        
        stdout.write(fileManager.contents(atPath: filename)!)
    }
} else {
    // Read from stdin
    stdout.write(stdin.readDataToEndOfFile())
}
