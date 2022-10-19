//
//  NotificationController.swift
//  Mini#01
//
//  Created by Marcelo Araujo on 06/10/22.
//

import Foundation
import UserNotifications

class NotificationController {
    
    func askPermissionNotification(){
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert,.badge, .sound]) { success, error in
            if success{
                print("aceitou")
            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(type: String, timeInterval: Double, title: String, body: String){
        
        
        var trigger: UNNotificationTrigger?
    
        if type == "time" {
           
           trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            
        }
        
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
    }
    
    
    

}
