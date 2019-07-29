//
//  AppDelegate.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreData
import UserNotifications
import SocketIO

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    public var username = ""
    public var community = ""
    public var friendRequestNum = 0
    
    let manager = SocketManager(socketURL: URL(string: "http://elife.free.idcfengye.com/")!, config: [.log(false), .compress])
    public var socket:SocketIOClient!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {_,_ in})
        
        UNUserNotificationCenter.current().delegate = self
            
        socket = manager.defaultSocket
        addSocketListener()
        socket.connect()
        
        checkIfLoggedIn()
        // Override point for customization after application launch.
        SVProgressHUD.setMinimumDismissTimeInterval(3)
        return true
    }
    
    func addSocketListener () {
        socket.on("recieve friend request") { (data, _) in
            let message = data[0] as! [String: String]
            if (message["name"]! == self.username) {
                
                let content = UNMutableNotificationContent()
                content.title = message["username"]! + "向您发送好友请求"
                //content.body = ""
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "recieve", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
                self.friendRequestNum += 1
                
                if let rootViewController = self.window?.rootViewController as! UITabBarController?{
                    if let tabItems = rootViewController.tabBar.items {
                        let tabItem = tabItems[2]
                        tabItem.badgeValue = String(self.friendRequestNum)
                    }
                }
            }
        }
        
        socket.on("accept friend request") { (data, _) in
            let message = data[0] as! [String: String]
            if (message["name"]! == self.username) {
                
                let content = UNMutableNotificationContent()
                content.title = message["username"]! + "已接受您的好友请求 🎉🎉🎉"
                //content.body = ""
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "accept", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
        
        socket.on("reject friend request") { (data, _) in
            let message = data[0] as! [String: String]
            if (message["name"]! == self.username) {
                
                let content = UNMutableNotificationContent()
                content.title = message["username"]! + "拒绝了您的好友请求 😢😢😢"
                //content.body = "周杰伦向您发送"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "reject", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if (response.notification.request.identifier == "recieve") {
            retrieveData()
            if (username != "") {
                let rootViewController = self.window!.rootViewController as! UITabBarController
                let mePage = rootViewController.viewControllers![2] as! UINavigationController
                
                let friendRequestPage = UIStoryboard(name: "Me", bundle: nil).instantiateViewController(withIdentifier: "friendRequestPage")
                let friendViewPage = UIStoryboard(name: "Me", bundle: nil).instantiateViewController(withIdentifier: "2")
                
                mePage.pushViewController(friendViewPage, animated: true)
                mePage.pushViewController(friendRequestPage, animated: true)
                
                rootViewController.selectedViewController = mePage
                
                self.friendRequestNum = 0
                
                if let rootViewController = self.window?.rootViewController as! UITabBarController?{
                    if let tabItems = rootViewController.tabBar.items {
                        let tabItem = tabItems[2]
                        tabItem.badgeValue = String(self.friendRequestNum)
                    }
                }
                    
            }
        } else if (response.notification.request.identifier == "accept") {
            retrieveData()
            if (username != "") {
                let rootViewController = self.window!.rootViewController as! UITabBarController
                let mePage = rootViewController.viewControllers![2] as! UINavigationController
                
                let friendViewPage = UIStoryboard(name: "Me", bundle: nil).instantiateViewController(withIdentifier: "2")
                
                mePage.pushViewController(friendViewPage, animated: true)
                
                rootViewController.selectedViewController = mePage
                
            }
        } 
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    
    func checkIfLoggedIn(){
        retrieveData()
        if (username != "") {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "MainPages", bundle: nil)
            let mainPage = mainStoryboard.instantiateViewController(withIdentifier: "mainPage") as! UITabBarController
            self.window?.rootViewController = mainPage
        }
    }
    
    
    public func showAlert (viewcontroller : UIViewController, message : String) {
        let alert = UIAlertController(title: "注意⚠️", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        viewcontroller.present(alert, animated: true, completion: nil)
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
    
    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func retrieveData() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<User>(entityName: "User")

            do {
                let results = try context.fetch(fetchRequest)

                for result in results {
                    if let username = result.username, let community =  result.community {
                        self.username = username
                        self.community = community
                    }
                }
            } catch {
                print("Error fetching data")
            }

        }
    }
}

