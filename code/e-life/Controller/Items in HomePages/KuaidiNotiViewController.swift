//
//  KuaidiNotiViewController.swift
//  e-life
//
//  Created by PalameMon on 7/24/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class CustomCellKuaidi : UITableViewCell {
    
    @IBOutlet var company: UILabel!
    @IBOutlet var num: UILabel!
}

class KuaidiNotiViewController: UIViewController {

    var notiArray : [JSON] = []
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Express/getExpress"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func fetchData() {
        AF.request(URL, method: .get, parameters: ["username": appDelegate.username]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                if let json = response.value {
                    let data = JSON(json).arrayValue
                    self.notiArray = data
                    self.tableView.reloadData()
                }
            } else{
                self.appDelegate.showAlert(viewcontroller: self, message: "您没有快递！")
            }
        }
    }
}

extension KuaidiNotiViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellKuaidi
        cell.company.text = "您的" + notiArray[indexPath.row]["company"].stringValue + "已到达"
        cell.num.text = notiArray[indexPath.row]["packageid"].stringValue
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 8, y: 5, width: self.view.frame.size.width - 20, height: 3000))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
        return cell
    }
}
