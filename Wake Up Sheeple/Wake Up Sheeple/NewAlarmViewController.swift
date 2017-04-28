//
//  NewAlarmViewController.swift
//  Wake Up Sheeple
//
//  Created by Kevin Kou on 4/1/17.
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit
import UserNotifications

class NewAlarmViewController: UIViewController {
    
    var tempAlarm : alarm?
    var time : DateComponents?
    var day : Int?
    var ring : Int?
    var row : Int?

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dayOfWeek: UISegmentedControl!
    @IBOutlet weak var songSelect: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    
    func setCategories() {
        let snoozeAction = UNNotificationAction(identifier: "snooze", title: "Snooze", options: [])
        let dismissAction = UNNotificationAction(identifier: "dismiss", title: "I'm awake!!", options: [])
        let alarmCategory = UNNotificationCategory(identifier: "alarm.category", actions: [snoozeAction, dismissAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        var dateComponents = DateComponents()
        let calendar = Calendar(identifier: .gregorian)
        //var components = calendar.dateComponents([.hour, .minute], from: datePicker.date)
        
        dateComponents.hour = calendar.dateComponents([.hour], from: datePicker.date).hour
        dateComponents.minute = calendar.dateComponents([.minute], from: datePicker.date).minute
        dateComponents.weekday = row! + 2
        

        time = dateComponents
        day  = dayOfWeek.selectedSegmentIndex
        ring = songSelect.selectedSegmentIndex
        
        //let center = UNUserNotificationCenter.current()
        //center.delegate = self
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //let trigger = UNCalendarNotificationTrigger(dateMatching: tempDC, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Wake up b****!!!"
        content.body = "Or else pay $$$"
        content.categoryIdentifier = "alarm.category"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "snooze", content: content, trigger: trigger)
        
        current.add(request)
        
        tempAlarm = alarm(d:day!, t:time!, r:ring!)
        let svc = segue.destination as! AlarmListViewController
        svc.alarms[row!] = tempAlarm!
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategories()
        dayOfWeek.selectedSegmentIndex = row!
        dayOfWeek.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
