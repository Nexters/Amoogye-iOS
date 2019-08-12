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
    var trigger: UNNotificationTrigger?
    let timeInterval = 0.01

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 타이머 종료 notification
        UNUserNotificationCenter.current().delegate = self
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timerModel.getTotalTime()), repeats: false)
        doneNotification()

        setupButtonStyle(cancelButton, pauseButton)
        setupProgressView()
        setTimeLabelText(hour: Int(timerModel.getLeftTime())/3600,
                         min: Int(timerModel.getLeftTime())%3600/60,
                         sec: Int(timerModel.getLeftTime())%3600%60)
        startTimer()
    }

    // 타이머 취소
    @IBAction func clickCancelButton(_ sender: Any) {
        timerModel.resetTimer()
        self.navigationController?.popViewController(animated: false)
    }

    // 타이머 일시정지, 다시시작
    @IBAction func clickPauseButton(_ sender: Any) {
        if timerModel.getState() == .Start { // 일시정지
            pauseTimer()
        } else { // 다시시작
            startTimer()
        }
    }

    @objc func decreaseTime() {
        if timerModel.getLeftTime() > timeInterval {
            timerModel.decreaseLeftTime(decrease: timeInterval)
            setTimeLabelText(hour: Int( timerModel.getLeftTime())/3600,
                              min: Int(timerModel.getLeftTime())%3600/60,
                              sec: Int(timerModel.getLeftTime())%3600%60)

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

    private func setTimeLabelText(hour: Int, min: Int, sec: Int) {
        timeLabel.text = String(format: "%02d : %02d : %02d", hour, min, sec)
    }

    private func setupProgressView() {
        progressView.progressTintColor = UIColor.white
        progressView.backgroundColor = UIColor(displayP3Red: 241/255, green: 245/255, blue: 247/255, alpha: 1)
        progressView.progressViewStyle = .bar
    }

    func doneNotification() {
        let hour = Int(timerModel.getTotalTime())/3600
        let min = Int(timerModel.getTotalTime())%3600/60
        let sec = Int(timerModel.getLeftTime())%3600%60

        var timeString = ""
        if hour != 0 {
            timeString.append("\(hour)시간 ")
        }
        if min != 0 {
            timeString.append("\(min)분 ")
        }
        if sec != 0 {
            timeString.append("\(sec)초 ")
        }

        let content = UNMutableNotificationContent()
        content.title = "타이머 종료"
        content.body = "\(timeString)타이머가 종료되었습니다."

        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    // MARK: - 타이머 작동 함수
    private func startTimer() {
        pauseButton.setTitle("일시정지", for: .normal)
        timerModel.startTimer(timeInterval: timeInterval)
        timerModel.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(TimerProgressViewController.decreaseTime), userInfo: nil, repeats: true)
    }

    private func pauseTimer() {
        pauseButton.setTitle("다시 시작", for: .normal)
        timerModel.pauseTimer()
    }

    func updateProgressView() {
        if progressView.progress <= 1 {
            progressView.progress = 1 - Float(timerModel.getLeftTime() / timerModel.getTotalTime())
            progressView.setProgress(progressView.progress, animated: true)
        }
    }
}

extension TimerProgressViewController: UNUserNotificationCenterDelegate {

    // 앱이 켜져 있을 때도 알림 받기
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
    }

}
