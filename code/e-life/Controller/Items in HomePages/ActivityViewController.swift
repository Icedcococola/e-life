//
//  ActivityViewController.swift
//  e-life
//
//  Created by PalameMon on 7/6/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class CustomCell3 : UITableViewCell {
    
    @IBOutlet var activityName: UILabel!
    @IBOutlet var venue: UILabel!
    @IBOutlet var date: UILabel!
}

class ActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet var dimView: UIView!
    
    //Mark: - popupView
    @IBOutlet var popupView: UIView!
    @IBOutlet var activityDetail: UILabel!
    @IBOutlet var closeButton: UIButton!
    

    let activitiesArray : [[String]] = [
        ["name", "venue", "date", "detail"],
        ["name1", "venue1", "date1", "detail1"],
        ["name2", "venue2", "date2", "detail2"],
        ["name3", "venue3", "date3", "detail3"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 15
        closeButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell3
        cell.activityName.text = activitiesArray[indexPath.row][0]
        cell.venue.text = activitiesArray[indexPath.row][1]
        cell.date.text = activitiesArray[indexPath.row][2]
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailText = activitiesArray[indexPath.row][3]
        activityDetail.text = detailText
        tableView.deselectRow(at: indexPath, animated: true)
        popupView.center = view.center
        
        popupView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(popupView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.7
            self.popupView.transform = .identity
        })
        
    }
    @IBAction func closePopup(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: ({
            self.dimView.alpha = 0
            self.popupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            }), completion: {(success) in
            self.popupView.removeFromSuperview()
        })
    }
    
    // Mark: - Fetch activity data from server
    
    

}
