//
//  SendPostViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class SendPostViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var companyPicker: UIPickerView!
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var remark: UITextView!
    let companies : [String] = [
        "中通快递",
        "申通快递",
        "顺丰快递"
    ]
    var chosenCompany : String = ""
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var remarkLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        responsiveDesign()
        // Do any additional setup after loading the view.
        datePicker.minuteInterval = 30
        companyPicker.delegate = self
        companyPicker.dataSource = self
    }
    
    func designUI(){
        submitButton.layer.cornerRadius = 10
    }
    
    func responsiveDesign() {
        let screenHeight = self.view.frame.height
        if (screenHeight < 669) {
            timeLabel.font = timeLabel.font.withSize(17)
            companyLabel.font = companyLabel.font.withSize(17)
            remarkLabel.font = remarkLabel.font.withSize(17)
        }
    }
    
    // UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return companies.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return companies[row]
//    }
    
    @IBAction func submit(_ sender: UIButton) {
        print("Submit")
        print(datePicker.date)
        print(chosenCompany)
        //call backend api to submit the request
        // Mark: - Make API Call
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenCompany = companies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "System", size: 20)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = companies[row]
        
        return pickerLabel!
    }
}
