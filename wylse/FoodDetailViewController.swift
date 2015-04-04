//
//  TagViewController.swift
//  wylse
//
//  Created by heaven on 3/21/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    @IBOutlet weak var foodTagTableView: UITableView!
    
    var food:Food!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        title = food.name
    }
}

let kFoodTagCell = "foodTagCell"

extension FoodDetailViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tags = food.tags {
            return tags.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let foodTagCell = tableView.dequeueReusableCellWithIdentifier(kFoodTagCell) as? UITableViewCell,
            let tag = food.tags?[indexPath.row] as Tag! {
                foodTagCell.textLabel?.text = tag.name
            return foodTagCell
        } else {
            return UITableViewCell()
        }
    }
    
}