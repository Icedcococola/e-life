//
//  DetailViewController.swift
//  e-life
//
//  Created by PalameMon on 7/15/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var id : String = ""
    var imageUrl = ""
    @IBOutlet var image: UIImageView!
    @IBOutlet var supplier: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var leftAmount: UILabel!
    @IBOutlet var timer: UILabel!
    @IBOutlet var detail: UILabel!
    @IBOutlet var add: UIButton!
    @IBOutlet var buyAmount: UITextField!
    
    let detailURL = "http://elifedemo.vipgz1.idcfengye.com/Goods/finddetail"
    let addURL = "http://elifedemo.vipgz1.idcfengye.com/Goodsuser/add"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var username = ""
    
    //
    @IBOutlet var supplierLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var remainingLabel: UILabel!
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var insertAmountLabel: UILabel!
    @IBOutlet var supplierDataLabel: UILabel!
    @IBOutlet var priceDataLabel: UILabel!
    @IBOutlet var remainingDataLabel: UILabel!
    @IBOutlet var countdownDataLabel: UILabel!
    @IBOutlet var detailDataText: UITextView!
    
    //constaint
    @IBOutlet var imageHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add.layer.cornerRadius = 10
        responsiveDesign()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        buyAmount.resignFirstResponder()
    }
    
    func responsiveDesign() {
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            
        } else if (screenHeight < 669) {
            supplierLabel.font = supplierLabel.font.withSize(17)
            priceLabel.font = supplier.font.withSize(17)
            remainingLabel.font = supplier.font.withSize(17)
            countdownLabel.font = supplier.font.withSize(17)
            detailLabel.font = supplier.font.withSize(17)
            insertAmountLabel.font = supplier.font.withSize(17)
            remainingDataLabel.font = supplier.font.withSize(17)
            supplierDataLabel.font = supplier.font.withSize(17)
            priceDataLabel.font = supplier.font.withSize(17)
            countdownDataLabel.font = supplier.font.withSize(17)
            detailDataText.font = supplier.font.withSize(17)
            
        } else if (screenHeight < 717) {
            supplierLabel.font = supplier.font.withSize(20)
            supplierDataLabel.font = supplierDataLabel.font.withSize(20)
            priceLabel.font = supplier.font.withSize(20)
            remainingLabel.font = supplier.font.withSize(20)
            countdownLabel.font = supplier.font.withSize(20)
            detailLabel.font = supplier.font.withSize(20)
            insertAmountLabel.font = supplier.font.withSize(20)
            remainingDataLabel.font = supplier.font.withSize(20)
            supplierDataLabel.font = supplier.font.withSize(20)
            priceDataLabel.font = supplier.font.withSize(20)
            countdownDataLabel.font = supplier.font.withSize(20)
            detailDataText.font = supplier.font.withSize(20)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        username = appDelegate.username
        fetchData()
    }
    
    // Make request for data
    func fetchData(){
        AF.request(detailURL, method: .post, parameters: ["username": self.username, "goodsid": id]).responseJSON { (response) in
            if let json = response.value {
                let data = JSON(json)
                let num = data["num"].stringValue
                self.supplier.text = data["store"].stringValue
                self.price.text = data["price"].stringValue
                self.leftAmount.text = data["remainingnum"].stringValue
                self.timer.text = data["deadline"].stringValue
                self.detailDataText.text = data["detail"].stringValue
                self.imageUrl = data["img"].stringValue
                self.image.downloaded(from: self.imageUrl)
                if (num != "0"){
                    self.setBought(num: num)
                }
            }
        }
    }
    
    @IBAction func join(_ sender: Any) {
        AF.request(addURL, method: .post, parameters: ["num": buyAmount.text!, "goodsid" : id, "username": self.username]).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                SVProgressHUD.showSuccess(withStatus: "加入成功")
                self.fetchData()
            } else {
                SVProgressHUD.showError(withStatus: "加入失败")
            }
        }
    }
    
    func setBought(num : String) {
        buyAmount.text = num
        buyAmount.isEnabled = false
        add.backgroundColor = .lightGray
        add.setTitle("已加入", for: .disabled)
        //add.titleLabel?.text = "已加入"
        add.isEnabled = false
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
