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
    
    //MARK: - Action
    @IBAction func newTagButtonTouched(sender: UIButton) {
        let alertController = UIAlertController(title: "New Tag",
            message: "Input tag name", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
            textField.returnKeyType = UIReturnKeyType.Done
        }
        alertController.addAction(UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add new tag",
            style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                if let textField:UITextField = alertController.textFields?.first as? UITextField,
                    let tagName = textField.text {
                        let newTag:Tag = Tag(name: tagName)
                        tagList.append(newTag)
                        
                        self.foodTagTableView.reloadData()
                }
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}

let kFoodTagCell = "foodTagCell"

extension FoodDetailViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let foodTagCell = tableView.dequeueReusableCellWithIdentifier(kFoodTagCell) as? UITableViewCell,
            let tag = tagList[indexPath.row] as Tag! {
                foodTagCell.textLabel?.text = tag.name
                
                if let tags = food.tags as [Tag]!,
                    let selectedTag = tags.filter({ $0 == tag }).first as Tag! {
                    foodTagCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                
                return foodTagCell
        } else {
            return UITableViewCell()
        }
    }
    
}

extension FoodDetailViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let tag = tagList[indexPath.row] as Tag! {
            if let selectedTagList = food.tags as [Tag]! {
                food.tags!.append(tag)
            } else {
                food.tags = [tag]
            }
        }
    }
    
}