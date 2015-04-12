//
//  TagViewController.swift
//  wylse
//
//  Created by heaven on 3/21/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var selectedTags = NSMutableArray()
    
    override func viewDidLoad() {
        // 땡겨서 새로고침 UIRefreshControl 추가
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "땡겨서 태그해제")
        refreshControl.addTarget(self, action: "reloadTags:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    // 선택된 태그 모두 해제 (Pull to Refresh) 떙겨서 태그해제
    func reloadTags(sender: AnyObject) {
        refreshControl.endRefreshing()
    }
    
    //MARK: - Action
    @IBAction func touchTagAdd(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "태그생성",
            message: "태그를 입력해주세요.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in }
        alertController.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "추가", style: UIAlertActionStyle.Default, handler: { (alertActoin) -> Void in
            
            if let textField = alertController.textFields?.first as? UITextField,

                let text = textField.text {
                    if text.isEmpty {
                        let emptyAlert = UIAlertController(title: "에러", message: "태그를 입력해주세요.", preferredStyle: UIAlertControllerStyle.Alert)
                        let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: nil)
                        emptyAlert.addAction(action)
                        
                        self.presentViewController(emptyAlert, animated: true, completion: nil)
                    }
                    
                    if self.compareTag(tagList, findText: text) {
                        let duplicateAlert = UIAlertController(title: "에러", message: "중복된 태그가 있습니다.", preferredStyle: UIAlertControllerStyle.Alert)
                        let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: nil)
                        duplicateAlert.addAction(action)
                        
                        self.presentViewController(duplicateAlert, animated: true, completion: nil)
                    }
                    else {
                        tagList.append(TagTemp(name: text))
                        self.tableView.reloadData()
                    }
                    
            }
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func compareTag(source: [TagTemp], findText: String) -> Bool {
        // 태그가 중복되는지 확인.
        var result = false
        for tag in source {
            if tag.name == findText {
                result = true
                break
            }
        }
        return result
    }
}

// MARK: - TableView Data source

let kTagCellIdentifier = "TagCell"
extension TagViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(kTagCellIdentifier) as? UITableViewCell,
            let cellText = tagList[indexPath.row] as TagTemp! {
            cell.textLabel!.text = cellText.name
                
            if selectedTags.containsObject(indexPath) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
}

extension TagViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if selectedTags.containsObject(indexPath) {
            selectedTags.removeObject(indexPath)
        }
        else {
            selectedTags.addObject(indexPath)
        }
        
        tableView.reloadData()
    }
}