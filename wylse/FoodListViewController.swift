//
//  ViewController.swift
//  wylse
//
//  Created by heaven on 3/21/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import UIKit

let kFoodDetailSegueIdentifier = "foodDetailSegue"

class FoodListViewController: UIViewController {
    
    @IBOutlet weak var foodListTableView: UITableView!
    
    var foodList = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Action
    @IBAction func newFoodButtonTouched(sender: UIButton) {
        let alertController = UIAlertController(title: "New Food",
            message: "Input food name", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
            textField.returnKeyType = UIReturnKeyType.Done
        }
        alertController.addAction(UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add new food",
            style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                if let textField:UITextField = alertController.textFields?.first as? UITextField,
                    let foodName = textField.text {
                        let food:Food = Food(name: foodName, tags: [Tag(name: "Tag")])
                        self.foodList.append(food)
                        self.foodListTableView.reloadData()
                }
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Segue
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if let segueIdentifier = identifier as String! where segueIdentifier == kFoodDetailSegueIdentifier,
            let selectedIndexPath = foodListTableView.indexPathForSelectedRow() as NSIndexPath!,
            let food = foodList[selectedIndexPath.row] as Food!,
            let tags = food.tags where tags.count > 0 {
                return true
        } else {
            return false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueIdentifier = segue.identifier as String! where segueIdentifier == kFoodDetailSegueIdentifier,
            let selectedIndexPath = foodListTableView.indexPathForSelectedRow() as NSIndexPath!,
            let food = foodList[selectedIndexPath.row] as Food! {
                let destination: FoodDetailViewController = segue.destinationViewController as! FoodDetailViewController
                destination.food = food
        }
    }
}

let kFoodCell = "FoodCell"

extension FoodListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let foodCell = tableView.dequeueReusableCellWithIdentifier(kFoodCell) as? UITableViewCell,
            let food = foodList[indexPath.row] as Food! {
                foodCell.textLabel?.text = food.name
                if food.tags?.count > 0 {
                    foodCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                }
                return foodCell
        } else {
            return UITableViewCell()
        }
    }
    
}
