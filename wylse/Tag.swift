//
//  Tag.swift
//  wylse
//
//  Created by heaven on 4/11/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import Foundation
import CoreData

class Tag: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var date: NSDate
}
