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
    private var isWorking: Bool = false
    private var leftTime: Double = 0
    private var totalTime: Double = 0
    var timer: Timer = Timer()

    private init() {}

    func startTimer(timeInterval: Double) {
        self.isWorking = true
    }

    func pauseTimer() {
        self.isWorking = false
        self.timer.invalidate()
    }

    func resetTimer() {
        self.isWorking = false
        self.timer.invalidate()
    }

    func finishTimer() {
        self.timer.invalidate()
    }

    func getIsWorking() -> Bool {
        return self.isWorking
    }

    func getLeftTime() -> Double {
        return self.leftTime
    }

    func getTotalTime() -> Double {
        return self.totalTime
    }

    func setTime(total: Double) {
        self.leftTime = total
        self.totalTime = total
    }

    func decreaseLeftTime(decrease: Double) {
        self.leftTime -= decrease
    }

}
