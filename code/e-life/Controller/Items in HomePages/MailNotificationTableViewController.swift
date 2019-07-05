//
//  MailNotificationTableViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class CustomCell2 : UITableViewCell{
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var contentText: UILabel!
}

class MailNotificationTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let notiArray : [[String]] = [
        ["title12", "content21"],
        ["title2", "content2"],
        ["title3", "content3"],
        ["title4", "content4"],
        ["title5", "content5"],
        ["title6", "content6"],
        ["title7", "content7"],
        ["title8", "content8"],
    ]

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell2
        print(indexPath.row)
        cell.titleLabel.text = notiArray[indexPath.row][0]
        cell.contentText.text = notiArray[indexPath.row][1]
        cell.layer.cornerRadius = 15
        return cell
    }
    
    // Mark: - Fetch data from server
}
