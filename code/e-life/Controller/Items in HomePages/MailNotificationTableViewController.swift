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
    
    let companyArray : [String] = ["中通快递", "申通快递", "顺丰快递"]
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Activity/findAll"
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
        cell.titleLabel.text = notiArray[indexPath.row]["title"].stringValue
        cell.contentText.text = notiArray[indexPath.row]["detail"].stringValue
        cell.contentView.backgroundColor = UIColor.clear
        
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            cell.titleLabel.font = cell.titleLabel.font.withSize(15)
            cell.contentText.font = cell.contentText.font.withSize(14)
        } else if (screenHeight < 668) {
            cell.titleLabel.font = cell.titleLabel.font.withSize(17)
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
    
    // Mark: - Fetch data from server
    func fetchData(){
        AF.request(URL, method: .post, parameters: ["community": self.community]).responseJSON { (response) in
            if let json = response.value{
                let noti = JSON(json).arrayValue
                self.notiArray = noti
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func findInfo(_ sender: Any) {
        fetchData()
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
        chosenCompany = companyArray[row]
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

