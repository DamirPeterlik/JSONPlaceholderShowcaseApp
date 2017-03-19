//
//  NotificationManager.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 19/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject {

    static let sharedManager = NotificationManager()
    
    // FIRST WE NEED REQUEST PERMISSION
    func requestNotificationPermission(completion: @escaping (_ Success: Bool) -> ()) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                    completion(granted)
            } else {
                print(error.debugDescription)
            }
        })
    }
    
    // THEN CREATE AND SCHEDULE NOTIFICATION
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        // Create our notification content
        let notif = UNMutableNotificationContent()
        
        // ONLY FOR EXTENSION
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "JSONPlaceholder Notification!"
        notif.subtitle = "Great you sorted the user list!"
        notif.body = "iOS 10 notifications"
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "sortTouchedNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error!)
                completion(false)
            } else {
                completion(true)
            }
        })
    }

    
}
