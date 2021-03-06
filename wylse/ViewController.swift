//
//  ViewController.swift
//  wylse
//
//  Created by heaven on 3/21/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    TODO: Picker Delegate, DataSource는 storyboard에서 연결

    @IBOutlet weak var tagSelectButton: UIButton!
    @IBOutlet weak var addFoodButton: UIButton!
    @IBOutlet weak var menuPickerView: UIPickerView!
    @IBOutlet weak var wylseButton: UIButton!
    
    var foodList: [String]! = []
    var selectedTags = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        for (NSString* family in [UIFont familyNames])
//        {
//            NSLog(@"%@", family);
//            
//            for (NSString* name in [UIFont fontNamesForFamilyName: family])
//            {
//                NSLog(@"  %@", name);
//            }
//        }
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: Fetch Food List
        // TODO: menuPickerView.reloadAllComponents()
        
        // 음식 리스트 로드.

        loadFood()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchAddFood(sender: UIButton) {
    }
    
    @IBAction func touchAddTag(sender: UIButton) {
    }

    @IBAction func touchWylse(sender: UIButton) {

        if(foodList.count != 0) {
            let randomValue:Int = random()%foodList.count
            menuPickerView.selectRow(randomValue, inComponent: 0, animated: true)
        }
    }
    
    @IBAction func touchFoodAdd(segue:UIStoryboardSegue) {
        let addFood = segue.sourceViewController as! FoodViewController
        
        if !addFood.addFoodName.text!.isEmpty {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.dataHelper.addFoods(addFood.addFoodName.text!, tags: addFood.tags, complete: {
                    self.loadFood()
                })
            dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    @IBAction func touchBackButton(segue:UIStoryboardSegue) {
        selectedTags.removeAllObjects()
        if let tagViewController = segue.sourceViewController as? TagViewController {
            let tagNames = tagViewController.getTagNames()
            for name in tagNames {
                selectedTags.addObject(name)
                
            }
            self.loadFood()
            
        } else if let _ = segue.sourceViewController as? FoodViewController {
            print("Food!")
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadFood() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        foodList.removeAll(keepCapacity: false)
        if let foods = appDelegate.dataHelper?.tagSelectedFood(selectedTags) {
            for food in foods {
                foodList.append(food.name)
            }
        }

        
        menuPickerView.reloadAllComponents()
    }

}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foodList.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let foodName = foodList[row] as String! {
            return foodName
        }else {
                return ""
        }
        
    }
}
