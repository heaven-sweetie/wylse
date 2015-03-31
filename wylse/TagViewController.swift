//
//  TagViewController.swift
//  wylse
//
//  Created by heaven on 3/21/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {
    
    var tagList = ["Test1", "Test2", "Test3"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        // TODO: TableView 표시
    }
    
    //MARK: - Action
    @IBAction func touchTagAdd(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "태그생성",
            message: "태그를 입력해주세요.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
        }
        alertController.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "추가", style: UIAlertActionStyle.Default, handler: { (alertActoin) -> Void in
            if let textField = alertController.textFields?.first as? UITextField, let text = textField.text {
                self.tagList.append(text)
                self.tableView.reloadData()
            }
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
}

let kTagCellIdentifier = "TagCell"
extension TagViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tagList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(kTagCellIdentifier) as? UITableViewCell,
            let cellText = self.tagList[indexPath.row] as String! {
            cell.textLabel!.text = cellText
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
}