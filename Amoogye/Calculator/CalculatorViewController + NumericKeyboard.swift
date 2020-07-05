//
//  CalculatorViewController + NumericKeyboard.swift
//  Amoogye
//
//  Created by 임수현 on 26/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension CalculatorViewController: NumericKeyboardDelegate {
    func inputNumber(number newValue: String) {
        guard let focused = inputManager?.focusedButton else { return }

        // 빈 칸이 없게 되면 <바꾸면> 버튼 활성화
        if focused == srcQuantityInput {
            renderChangeButton(isEnable: true)
        }

        guard let text = focused.title(for: .normal) else {
            focused.setTitle(newValue, for: .normal)
            focused.isPlaceholder = false
            checkNumericRange()
            return
        }

        // 값이 0이거나 placeholder였으면 숫자 문자열 처음부터 시작
        if text == "0" || focused.isPlaceholder {
            focused.setTitle(newValue, for: .normal)
            focused.isPlaceholder = false
            checkNumericRange()
            return
        }

        // 소수점 이하 1자리 이상 입력 시
        var compArr = text.components(separatedBy: ".")
        if compArr.count > 1 && compArr[1].count >= 1 {
            showNoticeLabel(message: decimalPointNotice)
            return
        }

        // 새로운 숫자륾 문자열에 추가
        focused.setTitle(text + newValue, for: .normal)
        checkNumericRange()
    }

    func deleteValue() {
        guard let focused = inputManager?.focusedButton, let text = focused.title(for: .normal) else {
            return
        }

        // placeholder일 경우 지워지지 않음
        if focused.isPlaceholder {
            return
        }

        // 문자열이 남아있을 경우 문자 하나를 지우기
        if text.count > 1 {
            let end = text.index(before: text.endIndex)

            // 지울 문자열이 . 인 경우 isDotClicked를 false로 변경
            if text[end] == "." {
                focused.isDotClicked = false
            }

            focused.setTitle(String(text[..<end]), for: .normal)
            return
        }

        // 문자열이 다 지워지면 placeholder로 바뀜
        focused.setTitle(focused.recentText, for: .normal)
        focused.isPlaceholder = true

        if focused.recentText == "" {
            renderChangeButton(isEnable: false)
        }
    }

    func inputDot() {
        guard let focused = inputManager?.focusedButton else {
            return
        }

        // isDotClicked가 true이면 . 입력 불가
        if focused.isDotClicked {
            return
        }

        // 빈 칸이 없게 되면 <바꾸면> 버튼 활성화
        if !(inputManager?.hasEmptyButtons() ?? false) {
            renderChangeButton(isEnable: true)
        }
        focused.isDotClicked = true

        // placeholder일 때 . 입력 시 0.으로 바뀜
        if focused.isPlaceholder {
            focused.setTitle("0.", for: .normal)
            focused.isPlaceholder = false
            return
        }

        // 빈 문자열이거나 "0"일 경우 0.으로 바뀜
        guard let text = focused.title(for: .normal) else {
            focused.setTitle("0.", for: .normal)
            return
        }
        if text == "" || text == "0" {
            focused.setTitle("0.", for: .normal)
            return
        }

        // 일반적으로는 문자열 뒤에 .이 추가됨
        focused.setTitle(text + ".", for: .normal)
    }

    func checkNumericRange() {
        guard let focused = inputManager?.focusedButton, let text = focused.title(for: .normal) else {
            return
        }

        if Double(text) ?? 0 >= 9999 {
            focused.isDotClicked = false
            focused.setTitle("9999", for: .normal)
            showNoticeLabel(message: maxRangeNotice)
        }
    }

    func checkEmpty() {
        guard let focused = inputManager?.focusedButton, let text = focused.title(for: .normal) else { return }
        if text == "" {
            changeButton.isEnabled = false
            return
        }
        changeButton.isEnabled = true
    }

    func showNoticeLabel(message: String) {
        noticeLabel.text = message
        noticeLabel.isHidden = false
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(hideNoticeLabel), userInfo: nil, repeats: false)
    }

    @objc func hideNoticeLabel() {
        noticeLabel.isHidden = true
    }
}
