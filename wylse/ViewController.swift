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
    
    var foodList = ["불백", "김치찌개", "인도네시아커피", "따뜻한 레몬티", "복분자 에이드"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: Fetch Food List
        // TODO: menuPickerView.reloadAllComponents()
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
        var randomValue:Int = random()%foodList.count
        menuPickerView.selectRow(randomValue, inComponent: 0, animated: true)
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
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if let foodName = foodList[row] as String! {
            return foodName
        }else {
                return ""
        }
        
    }
}
