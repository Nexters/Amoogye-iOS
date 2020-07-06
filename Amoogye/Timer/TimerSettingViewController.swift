//
//  TimerViewController.swift
//  Amoogye
//
//  Created by 임수현 on 25/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import UserNotifications

class TimerSettingViewController: UIViewController {

    var timerModel = TimerModel.shared
    let colorGreen = UIColor(displayP3Red: 109/255, green: 212/255, blue: 0, alpha: 1)

    var inputButtonManager: CustomInputButtonManager?
    var hourInputButton: CustomInputButton = CustomInputButton()
    var minInputButton: CustomInputButton = CustomInputButton()
    var secInputButton: CustomInputButton = CustomInputButton()

    @IBOutlet weak var hourInputView: UIView!
    @IBOutlet weak var minInputView: UIView!
    @IBOutlet weak var secInputView: UIView!

    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var numericKeyboardView: NumericKeyboardView!

    override func viewDidLoad() {
        super.viewDidLoad()

        numericKeyboardView.delegate = self
        setup()

        // 최초 실행 시 이전에 저장된 상태 불러오기
        timerModel.setDefaultTimerState()
        setTotalTimeText(time: timerModel.getTotalTime())
        switch timerModel.getState() {
        case .Ready:
            showTimerReady()

        case .Start:
            showTimerProgressView()

        case .Pause:
            showTimerProgressView()

        case .Finish:
            showTimerFinish()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        checkNotificationAuthorization() // 알림 권한 체크

        if timerModel.getState() == .Finish { // 타이머가 종료된 상태
            showTimerFinish()
        } else { // 타이머 준비 상태, 또는 취소된 상태
            showTimerReady()
        }
    }

    @IBAction func clickStart(_ sender: Any) {
        inputButtonManager?.focusOutAll()

        switch timerModel.getState() {
        case .Ready: // 시작 버튼 클릭
            if getSecond() > 0 {
                let timerDeadLine = Date(timeIntervalSinceNow: Double(getSecond()))
                timerModel.setDeadLine(deadLine: timerDeadLine)
                timerModel.setTotalTime(total: Double(getSecond()))
                timerModel.startTimer()
                showTimerProgressView()
            }
        case .Finish: // 종료 버튼 클릭
            timerModel.resetTimer()
            showTimerReady()

        default:
            break
        }

        timerModel.saveTimerState()
    }
}
