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
            message: "Input food name",
            preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
            textField.returnKeyType = UIReturnKeyType.Done
        }
        alertController.addAction(UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add new food",
            style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                if let textField:UITextField = alertController.textFields?.first as? UITextField,
                    let foodName = textField.text {
                        let food:Food = Food(name: foodName, tags: nil)
                        self.foodList.append(food)
                        self.foodListTableView.reloadData()
                        
                        self.foodListTableView.selectRowAtIndexPath(NSIndexPath(forRow: (self.foodList.count - 1), inSection: 0),
                            animated: true,
                            scrollPosition: UITableViewScrollPosition.None)
                        self.performSegueWithIdentifier(kFoodDetailSegueIdentifier, sender: self)
                        self.foodListTableView.deselectRowAtIndexPath(NSIndexPath(forRow: (self.foodList.count - 1), inSection: 0),
                            animated: true)
                }
        }))
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Segue
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
                foodCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return foodCell
        } else {
            return UITableViewCell()
        }
    }
    
}

extension FoodListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}