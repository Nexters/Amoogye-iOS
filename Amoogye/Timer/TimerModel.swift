//
//  TimerModel.swift
//  Amoogye
//
//  Created by 임수현 on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

class TimerModel {
    static let shared = TimerModel()
    var timer = Timer()
    var isWorkingTimer = false
    var time = 0

    private init() {}
}
