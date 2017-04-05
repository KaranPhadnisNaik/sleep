//
//  utilities.swift
//  Wake Up Sheeple
//
//  Created by Kevin Kou on 4/1/17.
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import Foundation

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
