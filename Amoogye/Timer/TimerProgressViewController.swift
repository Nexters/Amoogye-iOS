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
        setTimeLabelText(hour: Int(timerModel.getLeftTime())/3600,
                         min: Int(timerModel.getLeftTime())%3600/60,
                         sec: Int(timerModel.getLeftTime())%3600%60)
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        <#code#>
    }

    // 타이머 취소
    @IBAction func clickCancelButton(_ sender: Any) {
        timerModel.resetTimer()
        self.navigationController?.popViewController(animated: false)
    }

    // 타이머 일시정지, 다시시작
    @IBAction func clickPauseButton(_ sender: Any) {
        if timerModel.getIsWorking() { // 일시정지
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
            progressView.progress += Float(timeInterval / timerModel.getTotalTime())
            progressView.setProgress(progressView.progress, animated: true)
        }
    }
}
