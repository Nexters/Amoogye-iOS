//
//  TimerModel.swift
//  Amoogye
//
//  Created by 임수현 on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

class TimerModel {

    enum TimerStateEnum: Int {
        case Ready, Start, Pause, Finish
    }

    static let shared = TimerModel()
    private var state: TimerStateEnum = .Ready
    private var leftTime: Double = 0
    private var totalTime: Double = 0
    private var deadLine: Date = Date()
    var timer: Timer = Timer()

    private init() {}

    func startTimer() {
        self.state = .Start
        saveTimerState()
    }

    func pauseTimer() {
        self.state = .Pause
        self.timer.invalidate()
        saveTimerState()
    }

    func resetTimer() {
        self.state = .Ready
        self.leftTime = 0
        self.timer.invalidate()
        saveTimerState()
    }

    func finishTimer() {
        self.state = .Finish
        self.leftTime = 0
        self.timer.invalidate()
        saveTimerState()
    }

    func getState() -> TimerStateEnum {
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

    func setTimerState(state: TimerStateEnum) {
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

    func saveTimerState() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(state.rawValue, forKey: "TimerState")
        userDefaults.set(leftTime, forKey: "TimerLeft")
        userDefaults.set(totalTime, forKey: "TimerTotal")
        userDefaults.set(deadLine, forKey: "TimerDeadLine")
    }

    func setDefaultTimerState() {
        let userDefaults = UserDefaults.standard
        if let left = userDefaults.value(forKey: "TimerLeft"),
            let total = userDefaults.value(forKey: "TimerTotal"),
            let deadLine = userDefaults.value(forKey: "TimerDeadLine") {
            let state = userDefaults.integer(forKey: "TimerState")

            self.state = TimerStateEnum(rawValue: state)!
            self.totalTime = total as! Double
            self.deadLine = deadLine as! Date

            let intervalSinceNow = Double(self.deadLine.timeIntervalSinceNow)
            switch self.state {
            case .Ready:
                self.leftTime = totalTime
            case .Start:
                if intervalSinceNow > 0 {
                    self.leftTime = intervalSinceNow
                } else {
                    self.state = .Finish
                    self.leftTime = 0
                }
            case .Pause:
                self.leftTime = left as! Double
            case .Finish:
                self.leftTime = 0
            }
        }
    }

    func printTimer() {
        print("state: \(state)")
        print("left Time: \(leftTime)")
        print("total Time: \(totalTime)")
    }

}
