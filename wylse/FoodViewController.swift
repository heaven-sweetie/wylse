//
//  FoodViewController.swift
//  wylse
//
//  Created by heaven on 3/21/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import UIKit

class FoodViewController : UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var foodAddButton: UIButton!
    @IBOutlet weak var addFoodName: UITextField!
    @IBOutlet weak var addTag: UIButton!
    @IBOutlet weak var tagTableView: UITableView!

    var selectedTags = NSMutableArray()
    var foodName:String!
    var tags:[String]! = []
    
    override func viewDidLoad() {
        self.tagTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "touchFoodAdd" {
            foodName = addFoodName.text
        }
    }
    @IBAction func touchTagSelect(sender: UIButton) {
    }

    @IBAction func touchBackButton(segue:UIStoryboardSegue) {
        if let tagViewController = segue.sourceViewController as? TagViewController {
            selectedTags = tagViewController.selectedTags
            for selectItem in tagViewController.selectedTags {
                let tagName = tagViewController.tagList[selectItem.row] as Tag
                tags.append(tagName.name)
            }
            self.tagTableView.reloadData()
        }
    }
}

//MARK: UITableViewDataSource
extension FoodViewController:UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTags.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell:UITableViewCell = self.tagTableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell ,
            let tagName = self.tagList[selectedTags.objectAtIndex(indexPath.row).row] as TagTemp! {
            cell.textLabel?.text = tagName.name
            return cell

        } else {
            return UITableViewCell()
        }
    }
}

extension FoodViewController:UITableViewDelegate {
    
}