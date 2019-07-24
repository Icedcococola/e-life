//
//  SendPostViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class SendPostViewController: UIViewController {

    let companies : [String] = ["中通快递", "申通快递", "顺丰快递", "圆通快递", "韵达速递", "百世快递", "EMS"]
    
    let payments : [String] = ["现付", "到付", "月结", "第三方支付"]
    
    //required parameters
    var chosenCompany : String = ""
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func genOrderNum(){
        orderNumber = Double.random(in: 0..<1000)
    }
}


