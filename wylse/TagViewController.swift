//
//  TagViewController.swift
//  wylse
//
//  Created by heaven on 3/21/15.
//  Copyright (c) 2015 weirdmeetup. All rights reserved.
//

import UIKit
import CoreData

class TagViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var selectedTagIndexes = NSMutableArray()
    var tagList: [Tag]! = []
    
    override func viewDidLoad() {
        // 땡겨서 새로고침 UIRefreshControl 추가
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "땡겨서 태그해제")
        refreshControl.addTarget(self, action: "reloadTags:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        self.tableView.layer.cornerRadius = 4
        self.tableView.layer.backgroundColor = UIColor(red:0.98, green:0.97, blue:0.92, alpha:1).CGColor
        self.tableView.layer.shadowColor = UIColor.blackColor().CGColor
        self.tableView.layer.shadowOffset = CGSizeMake(0.0, 0.5)
        self.tableView.layer.shadowRadius = 0.5
        
        loadTag()
    }
    
    // 선택된 태그 모두 해제 (Pull to Refresh) 떙겨서 태그해제
    func reloadTags(sender: AnyObject) {
        allUnselectTags()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func loadTag() {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        tagList.removeAll(keepCapacity: false)
        
        if let tags = appDelegate.dataHelper?.fetchAllTags() {
            for tag in tags {
                tagList.append(tag)
            }
        }
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
                    else {
                        if self.compareTag(self.tagList, findText: text) {
                            let duplicateAlert = UIAlertController(title: "에러", message: "중복된 태그가 있습니다.", preferredStyle: UIAlertControllerStyle.Alert)
                            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: nil)
                            duplicateAlert.addAction(action)
                            
                            self.presentViewController(duplicateAlert, animated: true, completion: nil)
                        }
                        else {
                            var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                            let tagEntity = NSEntityDescription.entityForName("Tag", inManagedObjectContext: appDelegate.dataHelper.context)
                            var newTag = Tag(entity: tagEntity!, insertIntoManagedObjectContext: appDelegate.dataHelper.context)
                            
                            newTag.name = text
                            newTag.date = NSDate()
                            
                            self.tagList.append(newTag)
                            // 새로 넣는 태그를 선택한 아이템으로 추가.
                            var indexPath = NSIndexPath(forItem: self.tagList.count-1, inSection: 0)

                            /*
                            appDelegate.dataHelper.addTags(text, complete: {
                                self.loadTag()
                            })
                            */
                            
                            self.selectedTagIndexes.addObject(indexPath)
                            self.tableView.reloadData()
                        }
                    }
                    
            }
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func compareTag(source: [Tag], findText: String) -> Bool {
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
    
    func allUnselectTags() {
        selectedTagIndexes.removeAllObjects()
    }
    
    // 선택된 태그를 String 배열로 반환
    func getTagNames() -> [String]! {
        var tagNames = [String]()
        for tagIndex in selectedTagIndexes {
            let name = tagList[tagIndex.row] as Tag!
            tagNames.append(name.name)
        }
        return tagNames
    }
}

// MARK: - TableView Data source

let kTagCellIdentifier = "TagCell"
extension TagViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(kTagCellIdentifier) as? TagTableViewCell,
            let cellText = tagList[indexPath.row] as Tag! {
            cell.title!.text = cellText.name
                
            if selectedTagIndexes.containsObject(indexPath) {
                cell.mark.image = UIImage(named: "Mark")
            }
            else {
//                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.mark.image = UIImage(named: "EmptyMark")
            }
            return cell
        } else {
            
            var cell = TagTableViewCell()
            if selectedTagIndexes.containsObject(indexPath) {
//                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                cell.mark.image = UIImage(named: "Mark")
            }
            else {
//                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.mark.image = UIImage(named: "EmptyMark")
            }
            
            return cell
        }
        
    }
}

extension TagViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if selectedTagIndexes.containsObject(indexPath) {
            selectedTagIndexes.removeObject(indexPath)
        }
        else {
            selectedTagIndexes.addObject(indexPath)
        }
        
        tableView.reloadData()
    }
}