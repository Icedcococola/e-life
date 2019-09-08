//
//  MailNotificationTableViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CustomCell2 : UITableViewCell{
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var contentText: UILabel!
}

class MailNotificationTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var notiArray : [JSON] = []
    
    let companyArray : [String] = ["中通快递", "申通快递", "顺丰快递", "圆通快递", "韵达速递", "百世快递", "EMS"]
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Express/chaxun"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var community = ""
    var chosenCompany = ""
    @IBOutlet var tableView: UITableView!
    @IBOutlet var kuaidiNumLabel: UILabel!
    @IBOutlet var kuadiCompanyLabel: UILabel!
    @IBOutlet var kuadiNumInput: UITextField!
    @IBOutlet var submit: UIButton!
    @IBOutlet var kuadiCompanyPicker: UIPickerView!
    @IBOutlet var submitButton: UIButton!
    
    //constraint
    @IBOutlet var gap: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        community = appDelegate.community
        responsiveDesign()
        designUI()
    }
    
    func designUI(){
        submitButton.layer.cornerRadius = 10
    }
    
    func responsiveDesign() {
        let screenHeight = self.view.frame.height
        if (screenHeight < 669) {
            kuadiCompanyLabel.font = kuadiCompanyLabel.font.withSize(15)
            kuaidiNumLabel.font = kuaidiNumLabel.font.withSize(15)
            gap.constant = 20
        }
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell2
        cell.titleLabel.text = notiArray[indexPath.row]["AcceptStation"].stringValue
        cell.contentText.text = notiArray[indexPath.row]["AcceptTime"].stringValue
        cell.contentView.backgroundColor = UIColor.clear
        
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            cell.titleLabel.font = cell.titleLabel.font.withSize(15)
            cell.contentText.font = cell.contentText.font.withSize(14)
        } else if (screenHeight < 668) {
            cell.titleLabel.font = cell.titleLabel.font.withSize(16)
            cell.contentText.font = cell.contentText.font.withSize(15)
        }
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 30000))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0

        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)

        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        kuadiNumInput.resignFirstResponder()
    }
    
    // Mark: - Fetch data from server
    func fetchData(){
        AF.request(URL, method: .get, parameters: ["expNo": kuadiNumInput.text!, "expCode": chosenCompany]).responseJSON { (response) in
            print (response)
            if response.response?.statusCode == 200 {
                if let json = response.value{
                    let noti = JSON(json)
                    self.notiArray = noti["Traces"].arrayValue.reversed()
                    if (self.notiArray.isEmpty) {
                        self.appDelegate.showAlert(viewcontroller: self, message: "找不到该快递订单！\n请注意快递单号和快递公司")
                    } else {
                        self.tableView.reloadData()
                    }
                }
            } else {
                self.appDelegate.showAlert(viewcontroller: self, message: "找不到该快递订单！\n请注意快递单号和快递公司")
            }
        }
    }
    
    
    @IBAction func findInfo(_ sender: Any) {
        if (kuadiNumInput.text!.isEmpty) {
            appDelegate.showAlert(viewcontroller: self, message: "快递号不能为空")
        } else {
            fetchData()
        }
    }
}

extension MailNotificationTableViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return companyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch companyArray[row] {
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
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "System", size: 20)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = companyArray[row]
        
        return pickerLabel!
    }
    
}

