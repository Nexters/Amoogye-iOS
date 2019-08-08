//
//  TimerProgressViewController.swift
//  Amoogye
//
//  Created by 임수현 on 07/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class TimerProgressViewController: UIViewController {

    var timerModel = TimerModel.shared
    var timer = TimerModel.shared.time

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonStyle(cancelButton, pauseButton)
        setTimeLabelText(hour: timerModel.time/3600,
                         min: (timerModel.time%3600)/60,
                         sec: (timerModel.time%3600)%60)
        startTimer()
    }

    // 타이머 취소
    @IBAction func clickCancelButton(_ sender: Any) {
        timerModel.isWorkingTimer = false
        timerModel.timer.invalidate()
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }

    // 타이머 일시정지, 다시시작
    @IBAction func clickPauseButton(_ sender: Any) {
        if timerModel.isWorkingTimer { // 일시정지
            pauseTimer()
        } else { // 다시시작
            startTimer()
        }
    }

    @objc func decreaseTime() {
        if timerModel.time > 1 {
            timerModel.time -= 1
            setTimeLabelText(hour: timerModel.time/3600,
                              min: (timerModel.time%3600)/60,
                              sec: (timerModel.time%3600)%60)
        } else { // 시간 종료 시
            timerModel.timer.invalidate()
            self.presentingViewController?.dismiss(animated: false, completion: nil)
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

    // MARK: - 타이머 작동 함수
    private func startTimer() {
        pauseButton.setTitle("일시정지", for: .normal)
        timerModel.isWorkingTimer = true
        timerModel.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerProgressViewController.decreaseTime), userInfo: nil, repeats: true)
    }

    private func pauseTimer() {
        pauseButton.setTitle("다시 시작", for: .normal)
        timerModel.isWorkingTimer = false
        timerModel.timer.invalidate()
    }
}
