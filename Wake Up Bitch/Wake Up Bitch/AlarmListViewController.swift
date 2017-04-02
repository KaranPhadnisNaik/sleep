//
//  AlarmListViewController.swift
//  Wake Up Bitch
//
//  Created by Kevin Kou on 4/1/17.
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit
import Foundation


class AlarmListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var formatter = DateFormatter()

    
    var alarms: [alarm] = []
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var Edit: UIButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alarms.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        formatter.dateFormat = "hh:mm a"
        cell.textLabel?.text = formatter.string(from: self.alarms[indexPath.row].time as Date)
        
        switch(self.alarms[indexPath.row].day) {
        case 0:
            cell.textLabel?.text = (cell.textLabel?.text!)! + " Mondays"
            break
        default:
           break
        }
        
        return cell
    }


}

