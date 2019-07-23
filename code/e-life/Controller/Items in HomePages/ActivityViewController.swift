//
//  ActivityViewController.swift
//  e-life
//
//  Created by PalameMon on 7/6/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CustomCell3 : UITableViewCell {
    
    @IBOutlet var activityName: UILabel!
    @IBOutlet var venue: UILabel!
    @IBOutlet var date: UILabel!
}

class ActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet var tableView: UITableView!
    //@IBOutlet var dimView: UIView!
    
    //Mark: - popupView
    @IBOutlet var popupView: UIView!
    @IBOutlet var activityDetail: UILabel!
    @IBOutlet var closeButton: UIButton!
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Activity/findAll"
    
    var activitiesArray : [JSON] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        popupView.layer.cornerRadius = 15
        closeButton.layer.cornerRadius = 10
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching 活动安排 ...", attributes: nil)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        // Do any additional setup after loading the view.
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        fetchData()
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell3
        cell.activityName.text = activitiesArray[indexPath.row]["title"].stringValue
        cell.venue.text = activitiesArray[indexPath.row]["place"].stringValue
        cell.date.text = activitiesArray[indexPath.row]["activitytime"].stringValue
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 3000))
        
    whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailText = activitiesArray[indexPath.row]["detail"].stringValue
        activityDetail.text = detailText
        tableView.deselectRow(at: indexPath, animated: true)
        popupView.center = view.center
        
        popupView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(popupView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0.7
            self.popupView.transform = .identity
        })
        
    }
    @IBAction func closePopup(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: ({
            //self.dimView.alpha = 0
            self.popupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            }), completion: {(success) in
            self.popupView.removeFromSuperview()
        })
    }
    
    // Mark: - Fetch activity data from server
    func fetchData(){
        AF.request(URL, method: .post, parameters: ["community": self.appDelegate.community]).responseJSON { (response) in
            if let json = response.value{
                let activities = JSON(json).arrayValue
                self.activitiesArray = activities
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}
