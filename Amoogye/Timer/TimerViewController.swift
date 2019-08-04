//
//  TimerViewController.swift
//  Amoogye
//
//  Created by 임수현 on 25/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    var timer = Timer()
    var isWorkingTiemer = false
    var time = 0

    let colorGreen = UIColor(displayP3Red: 109/255, green: 212/255, blue: 0, alpha: 1)

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var hourTextfield: UITextField!
    @IBOutlet weak var minTextfield: UITextField!
    @IBOutlet weak var secTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startClick(_ sender: Any) {
        if isWorkingTiemer {
            pauseTimer()
        } else if getSecond() > 0 {
            startTimer()
        }
    }

    @IBAction func cancelClick(_ sender: Any) {
        // 취소 시
        resetTimer()
        hideCancelButton()
    }
}

extension TimerViewController {

    // MARK: - Setup 관련 함수
//    func setupMaxTimeLimit() {
//
//    }

    func setTextfieldsEnable(booltype: Bool) {
        hourTextfield.isEnabled = booltype
        minTextfield.isEnabled = booltype
        secTextfield.isEnabled = booltype
    }

    func setTextfield(hour: Int, min: Int, sec: Int) {
        hourTextfield.text = String(hour)
        minTextfield.text = String(min)
        secTextfield.text = String(sec)
    }

    func showStartButton() {
        startButton.backgroundColor = colorGreen
        startButton.setTitle("시작", for: .normal)
    }

    func showPauseButton() {
        startButton.backgroundColor = UIColor.red
        startButton.setTitle("일시정지", for: .normal)
    }

    func showCancelButton() {
        cancelButton.isHidden = false
    }

    func hideCancelButton() {
        cancelButton.isHidden = true
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

    // MARK: - 타이머 작동 관련 함수
    func startTimer() {
        isWorkingTiemer = true

        time = getSecond()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.decreaseTime), userInfo: nil, repeats: true)

        showPauseButton()
        showCancelButton()
        setTextfieldsEnable(booltype: false)
    }

    func pauseTimer() {
        isWorkingTiemer = false
        timer.invalidate()

        showStartButton()
    }

    func resetTimer() { // 시간 종료 시, 취소 시
        isWorkingTiemer = false
        timer.invalidate()

        showStartButton()
        hideCancelButton()
        setTextfieldsEnable(booltype: true)
        setTextfield(hour: 0, min: 0, sec: 0)

        time = 0
    }

    // 1초에 한번씩 실행
    @objc func decreaseTime() {
        if time > 1 {
            time -= 1
            setTextfield(hour: time/3600, min: (time%3600)/60, sec: (time%3600)%60)
        } else {
            // 시간 종료 시
            resetTimer()
            alertFinishTimer()
        }
    }

    func alertFinishTimer() {
        let alert = UIAlertController(title: "타이머 종료", message: "시간이 종료되었습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
