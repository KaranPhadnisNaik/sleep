//
//  utilities.swift
//  Wake Up Bitch
//
//  Created by Kevin Kou on 4/1/17.
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import Foundation

struct alarm {
    var day: Int
    var time: NSDate
    var tone: Int
    
    init(d: Int, t: NSDate, r: Int) {
        day = d
        time = t
        tone = r
    }
}
