//
//  AlarmListViewController.swift
//  Wake Up Sheeple
//
//  Created by Kevin Kou on 4/1/17.
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications


class AlarmListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let center = UNUserNotificationCenter.current()
    
    var time = DateComponents()
    var alarms: [alarm] = []
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var profilePic: UIImageView!


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "editAlarm") {
            let svc = segue.destination as! UINavigationController
            let nav = svc.topViewController as! NewAlarmViewController
            if let existing = sender as? alarm {
                // setup svc with existing
                nav.tempAlarm = existing
                nav.row = existing.day
            }
        }
    }
    
    @IBAction func saveAndUnwind(sender: UIStoryboardSegue) {
            tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photo = UIImage(named: "genericPic")
        profilePic.image = photo
        
        time.hour = 8
        time.minute = 0
        alarms = [alarm(d:0, t:time, r:0), alarm(d:1, t:time, r:0), alarm(d:2, t:time, r:0), alarm(d:3, t:time, r:0), alarm(d:4, t:time, r:0)]
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alarms.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        if self.alarms[indexPath.row].time.hour! > 12 {
            cell.textLabel?.text = "\(self.alarms[indexPath.row].time.hour! - 12 ?? 12)" + ":"
        }
        else {
            cell.textLabel?.text = "\(self.alarms[indexPath.row].time.hour ?? 12)" + ":"
        }
        if self.alarms[indexPath.row].time.minute! < 10 {
            cell.textLabel?.text = (cell.textLabel?.text!)! + "0"
        }
        cell.textLabel?.text = (cell.textLabel?.text!)! + "\(self.alarms[indexPath.row].time.minute ?? 0)"
        
        if self.alarms[indexPath.row].time.hour! > 12 {
            cell.textLabel?.text = (cell.textLabel?.text!)! + " PM"
        }
        else {
            cell.textLabel?.text = (cell.textLabel?.text!)! + " AM"
        }
        
        switch(self.alarms[indexPath.row].day) {
        case 0:
            cell.textLabel?.text = (cell.textLabel?.text!)! + " Mondays"
            break
        case 1:
            cell.textLabel?.text = (cell.textLabel?.text!)! + " Tuesdays"
            break
        case 2:
            cell.textLabel?.text = (cell.textLabel?.text!)! + " Wednesdays"
            break
        case 3:
            cell.textLabel?.text = (cell.textLabel?.text!)! + " Thursdays"
            break
        case 4:
            cell.textLabel?.text = (cell.textLabel?.text!)! + " Fridays"
            break
        default:
           break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editAlarm", sender: self.alarms[indexPath.row])
    }

}

