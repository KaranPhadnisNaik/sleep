//
//  NewAlarmViewController.swift
//  Wake Up Bitch
//
//  Created by Kevin Kou on 4/1/17.
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit

class NewAlarmViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dayOfWeek: UISegmentedControl!
    @IBOutlet weak var songSelect: UISegmentedControl!
    
    @IBAction func Save(_ sender: UIButton) {
        let time = datePicker.date
        let day  = dayOfWeek
        let ring = songSelect
        
        //alarms.append(d:day, t:time, r:ring)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
