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

    //var selectedTags = NSMutableArray()
    var foodName:String!
    var tags:[String]! = []
    
    override func viewDidLoad() {
        //self.tagTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tagTableView.layer.cornerRadius = 4
        self.tagTableView.layer.backgroundColor = UIColor(red:0.98, green:0.97, blue:0.92, alpha:1).CGColor
        self.tagTableView.layer.shadowColor = UIColor.blackColor().CGColor
        self.tagTableView.layer.shadowOffset = CGSizeMake(0.0, 0.5)
        self.tagTableView.layer.shadowRadius = 0.5
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
            let tagNames = tagViewController.getTagNames()
            for tag in tagNames {
                // 중복 선택한 태그가 아닌것만 추가
                if contains(tags, tag) == false {
                    tags.append(tag)
                }
            }
            self.tagTableView.reloadData()
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "touchFoodAdd" {
            if addFoodName.text.isEmpty  {
                let alert = UIAlertController(title: "경고", message: "텍스트를 입력해주세요.", preferredStyle: UIAlertControllerStyle.Alert)
                let alertAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
                println("false")
                return false
            } else {
                println("true")
                return true
            }
        } else {
            return true
        }

    }
}

//MARK: UITableViewDataSource
extension FoodViewController:UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell:TagTableViewCell = self.tagTableView.dequeueReusableCellWithIdentifier("cell") as? TagTableViewCell {
            let tagName = tags[indexPath.row]
            cell.title?.text = tagName
            return cell

        } else {
            return UITableViewCell()
        }
    }
}

extension FoodViewController:UITableViewDelegate {
    
}