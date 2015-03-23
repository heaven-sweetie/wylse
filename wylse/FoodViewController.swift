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
    
    var foodName:String!
    
    override func viewDidLoad() {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "touchFoodAdd" {
            foodName = addFoodName.text
        }
    }
//    @IBAction func touchFoodAdd(sender: UIButton) {
//        foodName = addFoodName.text
//        self.dismissViewControllerAnimated(false, completion: nil)
//    }
//    
//    @IBAction func touchBack(sender: UIButton) {
//        self.dismissViewControllerAnimated(false, completion: nil)
//    }
//    
//    
//    @IBAction func touchFoodAdd(segue:UIStoryboardSegue) {
//        let addFoodViewController = segue.
//    }
//    
//    @IBAction func touchBackButton(segue:UIStoryboardSegue) {
//        
//    }
}
