//
//  SendPostViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SendPostViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    let companies : [String] = ["中通快递", "申通快递", "顺丰快递", "圆通快递", "韵达速递", "百世快递", "EMS"]
    
    let payments : [String] = ["现付", "到付", "月结", "第三方支付"]
    
    //required parameters
    var chosenCompany : String = "ZTO"
    var orderNumber : Double = 0 //auto filled
    var payment : Int = 0
    let expType : Int = 1 //auto filled
    //reciever
    var name : String = ""
    var phoneNum : String = ""
    var provinceName : String = ""
    var cityName : String = ""
    var address : String = ""
    //sender
    var senderName : String = ""
    var senderPhoneNum : String = ""
    var senderProvinceName : String = ""
    var senderCityName : String = ""
    var senderAddress : String = ""
    
    //commodity
    var goodName : String = ""
    
    // IBOutlets
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var phoneNumInput: UITextField!
    @IBOutlet var provinceInput: UITextField!
    @IBOutlet var cityInput: UITextField!
    @IBOutlet var addressInput: UITextView!
    @IBOutlet var senderNameInput: UITextField!
    @IBOutlet var senderPhoneNumInput: UITextField!
    @IBOutlet var senderProvinceInput: UITextField!
    @IBOutlet var senderCityInput: UITextField!
    @IBOutlet var senderAddressInput: UITextView!
    
    //meta data
    @IBOutlet var goodNameInput: UITextField!
    @IBOutlet var companyPicker: UIPickerView!
    @IBOutlet var paymentPicker: UIPickerView!
    @IBOutlet var remark: UITextView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Express/jijian"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        genOrderNum()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        nameInput.resignFirstResponder()
//        phoneNumInput.resignFirstResponder()
//        remarkInput.resignFirstResponder()
//        senderNameInput.resignFirstResponder()
//        senderPhoneNumInput.resignFirstResponder()
//        senderRemarkInput.resignFirstResponder()
//    }
    
    func genOrderNum(){
        orderNumber = Double.random(in: 0..<1000)
    }
    
    
    @IBAction func submit(_ sender: Any) {
        metaInfoCheck()
        senderInfoCheck()
        recieverInfoCheck()
        
        let parameter =
            [   "OrderCode": String(orderNumber),
                "PayType": String(payment),
                "ExpType": String(expType),
                "ShipperCode": chosenCompany,
                "Receiver_Name": name,
                "Receiver_Phone": phoneNum,
                "Receiver_ProvinceName": provinceName,
                "Receiver_CityName": cityName,
                "Receiver_Address": address,
                "Sender_name": senderName,
                "Sender_phone": senderPhoneNum,
                "Sender_ProvinceName": senderProvinceName,
                "Sender_CityName": senderCityName,
                "Sender_Address": senderAddress,
                "Commodity_GoodsName": goodName,
            ] as [String : Any]
        
        AF.request(URL, method: .get, parameters: parameter).responseJSON { (response) in
                if response.response?.statusCode == 200 {
                    print (response.value as! String)
                } else {
                    self.appDelegate.showAlert(viewcontroller: self, message: "寄件失败！ Please try again!")
                }
        }
        
    }
    
    func metaInfoCheck() {
        if (goodNameInput.text!.isEmpty) {
            appDelegate.showAlert(viewcontroller: self, message: "商品名称不能为空")
        } else {
            goodName = goodNameInput.text!
        }
    }
    
    func senderInfoCheck(){
        senderName = senderNameInput.text!
        senderPhoneNum = senderPhoneNumInput.text!
        senderProvinceName = senderProvinceInput.text!
        senderCityName = senderCityInput.text!
        senderAddress = senderAddressInput.text!
        if senderName.isEmpty, senderPhoneNum.isEmpty {
            appDelegate.showAlert(viewcontroller: self, message: "姓名或手机号码不能为空")
        } else if senderCityName.isEmpty && senderProvinceName.isEmpty {
            appDelegate.showAlert(viewcontroller: self, message: "省和市不能同时为空")
        }
    }
    
    func recieverInfoCheck() {
        name = nameInput.text!
        phoneNum = phoneNumInput.text!
        provinceName = provinceInput.text!
        cityName = cityInput.text!
        address = addressInput.text!
        if name.isEmpty, phoneNum.isEmpty {
            appDelegate.showAlert(viewcontroller: self, message: "姓名或手机号码不能为空")
        } else if cityName.isEmpty && provinceName.isEmpty {
            appDelegate.showAlert(viewcontroller: self, message: "省和市不能同时为空")
        }
    }
    
}


extension SendPostViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == companyPicker) {
            return companies.count
        } else {
            return payments.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "System", size: 20)
            pickerLabel?.textAlignment = .center
        }
        
        if (pickerView == companyPicker) {
            pickerLabel?.text = companies[row]
        } else {
            pickerLabel?.text = payments[row]
        }
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == companyPicker) {
            switch companies[row] {
                case "中通快递":
                    chosenCompany = "ZTO"
                case "申通快递":
                    chosenCompany = "STO"
                case "圆通快递":
                    chosenCompany = "YTO"
                case "顺丰快递":
                    chosenCompany = "SF"
                case "韵达快递":
                    chosenCompany = "YD"
                case "EMS":
                    chosenCompany = "EMS"
                case "百世快递":
                    chosenCompany = "HTKY"
                default:
                    print ("Error")
            }
        } else {
            switch payments[row] {
                case "现付" :
                    payment = 1
                case "到付" :
                    payment = 2
                case "月结" :
                    payment = 3
                case "第三方支付" :
                    payment = 4
                default:
                    print ("Error")
            }
        }
    }
    
}


