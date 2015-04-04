//
//  Tag.swift
//  wylse
//
//  Created by heaven on 3/21/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import Foundation

class Tag : NSObject {
    let name: String
    
    init(name: String) {
        self.name = name
        
        super.init()
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let comparedObject = object as? Tag {
            return comparedObject.name == self.name
        } else {
            return false
        }
    }
}

var tagList = [Tag]()