//
//  Food.swift
//  wylse
//
//  Created by heaven on 3/21/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import Foundation

class FoodTemp : NSObject {
    
    let name: String
    var tags: [TagTemp]?
    
    init(name: String, tags:[TagTemp]?) {
        self.name = name
        self.tags = tags
        
        super.init()
    }
    
}