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
        hourInputView.addSubview(hourInputButton)
        minInputView.addSubview(minInputButton)
        secInputView.addSubview(secInputButton)

        inputButtonManager = CustomInputButtonManager(hourInputButton, minInputButton, secInputButton)
        inputButtonManager?.focusOn(button: hourInputButton)
        setupButtonStyle(startButton)

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
        // 알림 권한 체크
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {didAllow, _ in
            if !didAllow {
                // 알림 권한을 거부한 경우, 앱 설정 화면으로 이동
                self.alertPermissionDenied()
            }
        })

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

    func alertPermissionDenied() {
        self.tabBarController?.selectedIndex = 0
        let alert = UIAlertController(title: "권한 필요", message: "타이머 기능을 사용하려면 알림 권한 허용이 필요합니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension TimerSettingViewController {

    // MARK: - Setup 관련 함수
//    func setupMaxTimeLimit() {
//
//    }

    func setupButtonStyle(_ buttons: UIButton...) {
        for button in buttons {
            button.layer.cornerRadius = 6
        }
    }

    func setTotalTimeText(time: Double) {
        let hour = Int(time) / 3600
        let min = Int(time) % 3600 / 60
        let sec = Int(time) % 3600 % 60

        hourInputButton.setTitle(String(hour), for: .normal)
        minInputButton.setTitle(String(min), for: .normal)
        secInputButton.setTitle(String(sec), for: .normal)
    }

    func setTimerInputButtonEnable(booltype: Bool) {
//        inputButtonManager?.focusOutAll()
    }

    // MARK: - 상태에 따른 화면 전환
    // 준비 상태
    func showTimerReady() {
        secLabel.text = "초 뒤에"
        alertLabel.text = "알려드릴게요!"
        startButton.setTitle("시작하기", for: .normal)
        setTimerInputButtonEnable(booltype: true)
        numericKeyboardView.isHidden = false
    }

    // 시간 종료 상태
    func showTimerFinish() {
        secLabel.text = "초가"
        alertLabel.text = "끝났습니다!"
        startButton.setTitle("종료", for: .normal)
        setTimerInputButtonEnable(booltype: false)
        numericKeyboardView.isHidden = true
    }

    // 타이머 진행 또는 일시정지 상태
    func showTimerProgressView() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TimerProgressViewController") else { return }
        self.navigationController?.pushViewController(vc, animated: false)
    }

    // MARK: - 변환 관련 함수
    func getSecond() -> Int {
        let hour: Int = inputBtnTitleToInt(inputBtn: hourInputButton)
        let min: Int = inputBtnTitleToInt(inputBtn: minInputButton)
        let sec: Int = inputBtnTitleToInt(inputBtn: secInputButton)
//        let hour: Int = textfieldToInt(tf: hourTextfield)
//        let min: Int = textfieldToInt(tf: minTextfield)
//        let sec: Int = textfieldToInt(tf: secTextfield)
        return hour * 3600 + min * 60 + sec
    }

    func inputBtnTitleToInt(inputBtn: UIButton) -> Int {
        guard let text = inputBtn.title(for: .normal) else {
            return 0
        }
        return Int(text) ?? 0
    }
}

extension TimerSettingViewController: NumericKeyboardDelegate {
    func inputNumber(number newValue: String) {
        guard let inputButton = inputButtonManager?.focusedButton else {
            return
        }
        guard let text = inputButton.title(for: .normal) else {
            return
        }

        if text == "0" {
            inputButton.setTitle(newValue, for: .normal)
        } else {
            inputButton.setTitle(text+newValue, for: .normal)
        }
    }

    func deleteValue() {
        guard let inputButton = inputButtonManager?.focusedButton else {
            return
        }
        guard let text = inputButton.title(for: .normal) else {
            return
        }
        if text.count > 1 {
            let end = text.index(before: text.endIndex)
            inputButton.setTitle(String(text[..<end]), for: .normal)
        } else {
            inputButton.setTitle("0", for: .normal)
        }
    }

    func inputDot() {
        guard let inputButton = inputButtonManager?.focusedButton else {
            return
        }
        guard let text = inputButton.title(for: .normal) else {
            return
        }
        inputButton.setTitle(text+".", for: .normal)
    }

    func getLastInputValue() -> String {

        guard let inputButton = inputButtonManager?.focusedButton else {
            return ""
        }
        guard let text = inputButton.title(for: .normal) else {
            return ""
        }
        let lastIndex = text.index(before: text.endIndex)
        return String(text[lastIndex])
    }

}
