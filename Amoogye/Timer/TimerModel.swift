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
    var timer: Timer = Timer()
    var isWorkingTimer: Bool = false
    var leftTime: Double = 0
    var totalTime: Double = 0

    private init() {}
}
