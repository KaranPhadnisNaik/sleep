//
//  utilities.swift
//  Wake Up Sheeple
//
//  Created by Kevin Kou on 4/1/17.
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import Foundation
import UserNotifications

struct alarm {
    var day: Int
    var time: DateComponents
    var tone: Int
    
    init(d: Int, t: DateComponents, r: Int) {
        day = d
        time = t
        tone = r
    }
}

class notificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let identifier = response.actionIdentifier
        let request = response.notification.request
        if identifier == "snooze" {
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            newContent.body = "HEY SLEEPYHEAD GET UP"
            newContent.title = "SERIOUSLY WHY ARE YOU NOT UP"
            let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
            let newReq = UNNotificationRequest(identifier: request.identifier, content: newContent, trigger: newTrigger)
            //                let newCenter = UNUserNotificationCenter.current()
            //               newCenter.delegate = self
            current.add(newReq)
        }
        if identifier == "dismiss" {
            //cancel payment
        }
        
        completionHandler()
    }
}

