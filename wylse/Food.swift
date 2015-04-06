//
//  Food.swift
//  wylse
//
//  Created by heaven on 3/21/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import Foundation

class Food : NSObject {
    
    let name: String
    var tags: [Tag]?
    
    init(name: String, tags:[Tag]?) {
        self.name = name
        self.tags = tags
        
        super.init()
    }
    
}