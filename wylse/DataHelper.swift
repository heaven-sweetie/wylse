//
//  DataHelper.swift
//  wylse
//
//  Created by Hanul Park on 3/24/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import Foundation
import CoreData

public class DataHelper {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // 음식을 추가한다.
    func addFoods(foodName: String, tags: [String], complete: ()->()) {
        let foodEntity = NSEntityDescription.entityForName("Food", inManagedObjectContext: context)
        let newFood = Food(entity: foodEntity!, insertIntoManagedObjectContext: context)
        let newTag: NSMutableDictionary = [:]
        newFood.name = foodName
        for tag in tags {
            newTag[tag] = foodName
            print(tag)
           
        }
        newFood.tags = newTag
        do {
            try context.save()
        } catch _ {
        }
        complete()
    }
    
    // 태그를 추가한다.
    func addTags(tagName: String, complete: ()->()) {
        let tagEntity = NSEntityDescription.entityForName("Tag", inManagedObjectContext: context)
        let newTag = Tag(entity: tagEntity!, insertIntoManagedObjectContext: context)
        newTag.name = tagName
        
        
        do {
            try context.save()
        } catch _ {
        }
        
        complete()
    }
    
    func tagAtIndex(atIndex:Int) -> String {
        let tagRow = NSFetchRequest(entityName:"Tag")
        if let tagFetchResults = (try? context.executeFetchRequest(tagRow)) as? [Tag] {
            return tagFetchResults[atIndex].name
        } else {
            return ""
        }
    }
    
    func fetchAllTags() -> [Tag] {
        let tagFetchRequest = NSFetchRequest()
        tagFetchRequest.entity = NSEntityDescription.entityForName("Tag", inManagedObjectContext: context)
        tagFetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        let allTags = (try! context.executeFetchRequest(tagFetchRequest)) as! [Tag]
        
        return allTags
    }
    
    // TODO: 음식정보를 수정한다. (태그도 수정?)
    func modifyFood(foodName: String, complete: ()->()) {
        
    }
    
    // 모든 음식을 가져온다.
    func fetchAllFoods() -> [Food] {
        let foodFetchRequest = NSFetchRequest()
        foodFetchRequest.entity = NSEntityDescription.entityForName("Food", inManagedObjectContext: context)
        
        let allFoods = (try! context.executeFetchRequest(foodFetchRequest)) as! [Food]
        
        return allFoods
    }
    /*
    param 값과 하나라도 같은 테그가 있을시 리턴
    
    param   선택된 태그 Array
    return  선택된 태그와 일치하는 값이 있는 Food Array
    */
    func tagSelectedFood(selectedTags: NSMutableArray) -> [Food] {
        let foodFetchRequest = NSFetchRequest()
        foodFetchRequest.entity = NSEntityDescription.entityForName("Food", inManagedObjectContext: context)
        var selectedFood : [Food]! = []
        let allFoods = (try! context.executeFetchRequest(foodFetchRequest)) as! [Food]

        if selectedTags.count != 0 {
            for food in allFoods {
                print(selectedTags.count, food.tags.allKeys)
                if ((selectedTags.firstObjectCommonWithArray(food.tags.allKeys)) != nil) {
                    selectedFood.append(food)
                }
            }
            print(selectedFood)
            return selectedFood
        }else {
            return allFoods
        }

    }
}