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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        var dateComponents = DateComponents()
        let calendar = Calendar(identifier: .gregorian)
        //var components = calendar.dateComponents([.hour, .minute], from: datePicker.date)
        
        dateComponents.hour = calendar.dateComponents([.hour], from: datePicker.date).hour
        dateComponents.minute = calendar.dateComponents([.minute], from: datePicker.date).minute
        dateComponents.day = row
        

        time = dateComponents
        day  = dayOfWeek.selectedSegmentIndex
        ring = songSelect.selectedSegmentIndex
        
        var tempDC = dateComponents
        tempDC.day = tempDC.day! + 2
        
        let center = UNUserNotificationCenter.current()
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        //let trigger = UNCalendarNotificationTrigger(dateMatching: tempDC, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Wake up b****!!!"
        content.body = "Or else pay $$$"
        content.categoryIdentifier = "customIdentifier"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
        tempAlarm = alarm(d:day!, t:time!, r:ring!)
        let svc = segue.destination as! AlarmListViewController
        svc.alarms[row!] = tempAlarm!
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
