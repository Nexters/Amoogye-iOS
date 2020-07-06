//
//  TimerSettingViewController + TimerState.swift
//  Amoogye
//
//  Created by 임수현 on 2020/07/06.
//  Copyright © 2020 KookKook. All rights reserved.
//

import UIKit

extension TimerSettingViewController {
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
}

extension TimerSettingViewController {
    // MARK: - 타이머 세팅 관련 함수
//    func setupMaxTimeLimit() {
//
//    }

    func setTotalTimeText(time: Double) {
        let hour = Int(time) / 3600
        let min = Int(time) % 3600 / 60
        let sec = Int(time) % 3600 % 60

        hourInputButton.setTitle(String(hour), for: .normal)
        minInputButton.setTitle(String(min), for: .normal)
        secInputButton.setTitle(String(sec), for: .normal)
    }

    func setTimerInputButtonEnable(booltype: Bool) {
        hourInputButton.isEnabled = booltype
        minInputButton.isEnabled = booltype
        secInputButton.isEnabled = booltype
        inputButtonManager?.focusOutAll()
    }

    // MARK: - 변환 관련 함수
    func getSecond() -> Int {
        let hour: Int = inputBtnTitleToInt(inputBtn: hourInputButton)
        let min: Int = inputBtnTitleToInt(inputBtn: minInputButton)
        let sec: Int = inputBtnTitleToInt(inputBtn: secInputButton)
        return hour * 3600 + min * 60 + sec
    }

    func inputBtnTitleToInt(inputBtn: UIButton) -> Int {
        guard let text = inputBtn.title(for: .normal) else {
            return 0
        }
        return Int(text) ?? 0
    }
}
