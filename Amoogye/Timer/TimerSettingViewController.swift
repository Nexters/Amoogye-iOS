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

    var textfiledManager: CustomTextfieldManager?

    @IBOutlet weak var hourTextfield: CustomTextField!
    @IBOutlet weak var minTextfield: CustomTextField!
    @IBOutlet weak var secTextfield: CustomTextField!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var numericKeyboardView: NumericKeyboardView!

    override func viewDidLoad() {
        super.viewDidLoad()

        numericKeyboardView.delegate = self
        textfiledManager = CustomTextfieldManager(hourTextfield, minTextfield, secTextfield)
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

    // 화면 터치 시 textfield focusOut
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textfiledManager?.focusOutAll()
    }

    @IBAction func clickStart(_ sender: Any) {
        textfiledManager?.focusOutAll()

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

        hourTextfield.text = String(hour)
        minTextfield.text = String(min)
        secTextfield.text = String(sec)
    }

    func setTimerTextfieldsEnable(booltype: Bool) {
        hourTextfield.isEnabled = booltype
        minTextfield.isEnabled = booltype
        secTextfield.isEnabled = booltype
        textfiledManager?.focusOutAll()
    }

    // MARK: - 상태에 따른 화면 전환
    // 준비 상태
    func showTimerReady() {
        secLabel.text = "초 뒤에"
        alertLabel.text = "알려드릴게요!"
        startButton.setTitle("시작하기", for: .normal)
        setTimerTextfieldsEnable(booltype: true)
        numericKeyboardView.isHidden = false
    }

    // 시간 종료 상태
    func showTimerFinish() {
        secLabel.text = "초가"
        alertLabel.text = "끝났습니다!"
        startButton.setTitle("종료", for: .normal)
        setTimerTextfieldsEnable(booltype: false)
        numericKeyboardView.isHidden = true
    }

    // 타이머 진행 또는 일시정지 상태
    func showTimerProgressView() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TimerProgressViewController") else { return }
        self.navigationController?.pushViewController(vc, animated: false)
    }

    // MARK: - 변환 관련 함수
    func getSecond() -> Int {
        let hour: Int = textfieldToInt(tf: hourTextfield)
        let min: Int = textfieldToInt(tf: minTextfield)
        let sec: Int = textfieldToInt(tf: secTextfield)
        return hour * 3600 + min * 60 + sec
    }

    func textfieldToInt(tf: UITextField) -> Int {
        guard let text = tf.text else {
            return 0
        }
        return Int(text) ?? 0
    }
}

extension TimerSettingViewController: NumericKeyboardDelegate {
    func inputNumber(number newValue: String) {
        guard let textField = textfiledManager?.focusedTextField else {
            return
        }
        guard let text = textField.text else {
            return
        }

        if text == "0" {
            textField.text = newValue
        } else {
            textField.text = text + newValue
        }
    }

    func deleteValue() {
        guard let textField = textfiledManager?.focusedTextField else {
            return
        }
        guard let text = textField.text else {
            return
        }

        if text.count > 1 {
            let end = text.index(before: text.endIndex)
            textField.text = String(text[..<end])
        } else {
            textField.text = "0"
        }
    }

    func inputDot() {
        guard let textField = textfiledManager?.focusedTextField else {
            return
        }
        guard let text = textField.text else {
            return
        }

        textField.text = text + "."
    }

    func getLastInputValue() -> String {
        guard let textField = textfiledManager?.focusedTextField else {
            return ""
        }
        guard let text = textField.text else {
            return ""
        }

        let lastIndex = text.index(before: text.endIndex)
        return String(text[lastIndex])
    }

}
