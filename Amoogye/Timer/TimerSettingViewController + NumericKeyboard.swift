//
//  TimerSettingViewController + NumericKeyboard.swift
//  Amoogye
//
//  Created by 임수현 on 2020/07/06.
//  Copyright © 2020 KookKook. All rights reserved.
//

import UIKit

extension TimerSettingViewController: NumericKeyboardDelegate {

    // MARK: - 숫자 버튼 입력
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

        inputButton.setTitleColor(UIColor.amOrangeyRed, for: .normal)
    }

    // MARK: - 삭제 버튼 입력
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
            inputButton.setTitleColor(UIColor.amOrangeyRed, for: .normal)
        } else {
            inputButton.setTitle("0", for: .normal)
            inputButton.setTitleColor(UIColor.amLightBlueGrey, for: .normal)
        }
    }

    // MARK: - . 버튼 입력
    func inputDot() {
        guard let inputButton = inputButtonManager?.focusedButton else {
            return
        }
        guard let text = inputButton.title(for: .normal) else {
            return
        }
        inputButton.setTitle(text+".", for: .normal)
        inputButton.setTitleColor(UIColor.amOrangeyRed, for: .normal)
    }

    // MARK: - 문자열의 마지막 값 반환
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
