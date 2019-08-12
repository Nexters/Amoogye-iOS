//
//  TimerModel.swift
//  Amoogye
//
//  Created by 임수현 on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

class TimerModel {

    enum TimerState {
        case Ready, Start, Pause, Finish
    }

    static let shared = TimerModel()
    private var state: TimerState = .Ready
    private var leftTime: Double = 0
    private var totalTime: Double = 0
    private var deadLine: Date = Date()
    var timer: Timer = Timer()

    private init() {}

    func startTimer(timeInterval: Double) {
        self.state = .Start
    }

    func pauseTimer() {
        self.state = .Pause
        self.timer.invalidate()
    }

    func resetTimer() {
        self.state = .Ready
        self.timer.invalidate()
    }

    func finishTimer() {
        self.state = .Finish
        self.timer.invalidate()
    }

    func getState() -> TimerState {
        return self.state
    }

    func getLeftTime() -> Double {
        return self.leftTime
    }

    func getTotalTime() -> Double {
        return self.totalTime
    }

    func getDeadLine() -> Date {
        return self.deadLine
    }

    func setTotalTime(total: Double) {
        self.leftTime = total
        self.totalTime = total
    }

    func setTimerState(state: TimerState) {
        self.state = state
    }

    func setLeftTime(left: Double) {
        self.leftTime = left
    }

    func setDeadLine(deadLine: Date) {
        self.deadLine = deadLine
    }

    func decreaseLeftTime(decrease: Double) {
        self.leftTime -= decrease
    }

}
