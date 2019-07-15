//
//  MeViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import CoreData

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var PhoneNum: UIView!
    @IBOutlet var phoneNumber: UILabel!
    
    let configItems : [String] = [
        "换用户名",
        "换密码",
        "换手机号",
        "实名验证"
    ]
    let ID = [
        "1",
        "2",
        "3",
        "4"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func designUI(){
        PhoneNum.layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.cellLabel.text = configItems[indexPath.row]
        cell.icon.text = ">"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = ID[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: id)
        navigationController?.pushViewController(viewController!, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func setUsernameAndPhoneNum () {
        // Mark: - Retrieve information from core data and set them correctly
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
