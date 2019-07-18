//
//  MeViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var username: UILabel!
    @IBOutlet var community: UILabel!
    
    //constraint
    @IBOutlet var fromRightMeLabel: NSLayoutConstraint!
    
    @IBOutlet var fromRightAvartar: NSLayoutConstraint!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let configItems : [String] = [
        "换用户名",
        "换密码",
        "换手机号",
        "实名验证",
        "好友管理"
    ]
    let ID = [
        "1",
        "2",
        "3",
        "4",
        "5"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resposiveDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUsernameAndCommunity()
    }
    
    func resposiveDesign(){
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            fromRightMeLabel.constant = 10
            fromRightAvartar.constant = 10
        } else if (screenHeight < 668) {
            fromRightMeLabel.constant = 20
            fromRightAvartar.constant = 20
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let screenHeight = self.view.frame.height
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.cellLabel.text = configItems[indexPath.row]
        if (screenHeight < 569) {
            cell.cellLabel.font = cell.cellLabel.font.withSize(15)
        } else if (screenHeight < 668) {
            cell.cellLabel.font = cell.cellLabel.font.withSize(17)
        }
        cell.icon.text = ">"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = ID[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: id)
        navigationController?.pushViewController(viewController!, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func setUsernameAndCommunity () {
        // Mark: - Retrieve information from core data and set them correctly
        username.text = appDelegate.username
        community.text = appDelegate.community
    }
    @IBAction func logOut(_ sender: Any) {
        resetAllRecords(in: "User")
        performSegue(withIdentifier: "gotoLogin", sender: nil)
    }
    
    func resetAllRecords(in entity : String) // entity = Your_Entity_Name
    {
        
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
}
