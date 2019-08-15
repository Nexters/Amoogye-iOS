//
//  TimerProgressViewController.swift
//  Amoogye
//
//  Created by 임수현 on 07/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import UserNotifications

class TimerProgressViewController: UIViewController {

    var timerModel = TimerModel.shared
    let timeInterval = 0.01

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonStyle(cancelButton, pauseButton)
        setupProgressView()
        setTimeLabelText(time: timerModel.getLeftTime())

        switch timerModel.getState() {
        case .Start:
            startTimer()
        case .Pause:
            pauseTimer()
        default:
            break
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        switch timerModel.getState() {
        case .Start:
            startTimer()
        case .Pause:
            pauseTimer()
        default:
            break
        }
    }

    // 타이머 취소
    @IBAction func clickCancelButton(_ sender: Any) {
        cancelTimer()
    }

    // 타이머 일시정지, 다시시작
    @IBAction func clickPauseButton(_ sender: Any) {
        switch timerModel.getState() {
        case .Start:
            pauseTimer()
        case .Pause:
            startTimer()
        default:
            break
        }
    }

    @objc func decreaseTime() {
        if timerModel.getLeftTime() > timeInterval {
            timerModel.decreaseLeftTime(decrease: timeInterval)
            setTimeLabelText(time: timerModel.getLeftTime())
            updateProgressView()
        } else { // 시간 종료 시
            timerModel.finishTimer()
            self.navigationController?.popViewController(animated: false)
        }
    }
}

extension TimerProgressViewController {

    // MARK: - setup 관련 함수
    private func setupButtonStyle(_ buttons: UIButton...) {
        for button in buttons {
            button.layer.cornerRadius = 6
        }
    }

    private func setTimeLabelText(time: Double) {
        let hour = Int(time) / 3600
        let min = Int(time) % 3600 / 60
        let sec = Int(time) % 3600 % 60

        timeLabel.text = String(format: "%02d : %02d : %02d", hour, min, sec)
    }

    private func setupProgressView() {
        progressView.progressTintColor = UIColor.white
        progressView.backgroundColor = UIColor(displayP3Red: 241/255, green: 245/255, blue: 247/255, alpha: 1)
        progressView.progressViewStyle = .bar
        progressView.progress = 1 - Float(timerModel.getLeftTime() / timerModel.getTotalTime())
    }

    func doneNotification() {
        print("끝!!!!!!")
        let hour = Int(timerModel.getTotalTime()) / 3600
        let min = Int(timerModel.getTotalTime()) % 3600 / 60
        let sec = Int(timerModel.getTotalTime()) % 3600 % 60

        var timeString = ""
        if hour > 0 {
            timeString.append("\(hour)시간 ")
        }
        if min > 0 {
            timeString.append("\(min)분 ")
        }
        if sec > 0 {
            timeString.append("\(sec)초 ")
        }

        let content = UNMutableNotificationContent()
        content.title = "타이머 종료"
        content.body = "\(timeString)타이머가 종료되었습니다."

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timerModel.getLeftTime(), repeats: false)
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    // MARK: - 타이머 작동 함수
    private func startTimer() {
        doneNotification()
        pauseButton.setTitle("일시정지", for: .normal)
        timerModel.startTimer()
        timerModel.timer.invalidate()
        timerModel.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(TimerProgressViewController.decreaseTime), userInfo: nil, repeats: true)
    }

    private func pauseTimer() {
        cancelNotification()
        pauseButton.setTitle("다시 시작", for: .normal)
        timerModel.pauseTimer()
    }

    private func cancelTimer() {
        cancelNotification()
        timerModel.resetTimer()
        self.navigationController?.popViewController(animated: false)
    }

    func updateProgressView() {
        if progressView.progress <= 1 {
            progressView.progress = 1 - Float(timerModel.getLeftTime() / timerModel.getTotalTime())
            progressView.setProgress(progressView.progress, animated: true)
        }
    }
}
