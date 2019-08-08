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
    var timer = TimerModel.shared.leftTime
    let timeInterval = 0.01

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonStyle(cancelButton, pauseButton)
        setupProgressView()
        setTimeLabelText(hour: Int(timerModel.leftTime)/3600,
                         min: Int(timerModel.leftTime)%3600/60,
                         sec: Int(timerModel.leftTime)%3600%60)
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
        if timerModel.leftTime > timeInterval {
            timerModel.leftTime -= timeInterval
            setTimeLabelText(hour: Int( timerModel.leftTime)/3600,
                              min: Int(timerModel.leftTime)%3600/60,
                              sec: Int(timerModel.leftTime)%3600%60)

            updateProgressView()
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

    private func setupProgressView() {
        progressView.progressTintColor = UIColor.white
        progressView.backgroundColor = UIColor(displayP3Red: 241/255, green: 245/255, blue: 247/255, alpha: 1)
        progressView.progressViewStyle = .bar
    }

    // MARK: - 타이머 작동 함수
    private func startTimer() {
        pauseButton.setTitle("일시정지", for: .normal)
        timerModel.isWorkingTimer = true
        timerModel.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(TimerProgressViewController.decreaseTime), userInfo: nil, repeats: true)
    }

    private func pauseTimer() {
        pauseButton.setTitle("다시 시작", for: .normal)
        timerModel.isWorkingTimer = false
        timerModel.timer.invalidate()
    }

    func updateProgressView() {
        if progressView.progress <= 1 {
        progressView.progress += Float(timeInterval / timerModel.totalTime)
        progressView.setProgress(progressView.progress, animated: true)
        }
    }
}
