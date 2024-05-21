//
//  ViewController.swift
//  NotificationUsage
//
//  Created by Kaan Uzun on 21.05.2024.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var checkPermission = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Asking allowence for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge],
                                                                completionHandler: { granted, error in
            self.checkPermission = granted
            
        })
        
        UNUserNotificationCenter.current().delegate = self
    }

    @IBAction func btnCreateNotification(_ sender: Any) {
        if checkPermission {
            //Creating content
            let content = UNMutableNotificationContent()
            content.title = "Title"
            content.subtitle = "Subtitle"
            content.body = "Content"
            content.badge = 1
            content.sound = UNNotificationSound.default
            
//            //Setting time
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true) //reapeating notifications
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) //non-repeating notifications
                      
            //Notification Request
            let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
        
    }
    
}

//banner on top of the app, alert classic notification alert on the homepage

extension ViewController : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.sound,.badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let app = UIApplication.shared
        
        if app.applicationState == .active{
            print("Frontpage: Notification Clicked")
        }
        
        if app.applicationState == .inactive{
            print("Background: Notification Clicked")
        }
        
       // app.applicationIconBadgeNumber = 0
        center.setBadgeCount(0)
        
        completionHandler()
    }
}

