//
//  CalculatorViewController + keyboard.swift
//  Amoogye
//
//  Created by 임수현 on 21/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

// MARK: - Numeric Keyboard
extension CalculatorViewController: NumericKeyboardDelegate {
    func inputNumber(number newValue: String) {
        guard let selectedButton = inputManager?.selectedButton,
            let text = selectedButton.title(for: .normal) else {
                inputManager?.selectedButton?.setTitle(newValue)
                return
        }

        // 입력된 숫자가 0또는 회색일 경우 -> 새로 갱신
        if text == "0" || selectedButton.titleColor(for: .normal) == UIColor.amLightBlueGrey {
            selectedButton.setTitle(newValue)
            return
        }

        selectedButton.setTitle(text + newValue)
    }

    func deleteValue() {
        guard let selectedButton = inputManager?.selectedButton,
            let text = selectedButton.title(for: .normal) else {
                return
        }

        if text.count > 1 {
            let end = text.index(before: text.endIndex)
            selectedButton.setTitle(String(text[..<end]))
            return
        }

        selectedButton.setPlaceholder()
    }

    func inputDot() {
        guard let selectedButton = inputManager?.selectedButton,
            let text = inputManager?.selectedButton?.title(for: .normal)
            else { return }

        // 인분 입력창일 경우 . 사용 불가
        if selectedButton != srcQuantityInput {
            return
        }

        if text == "" || getLastInputValue() == "." {
            selectedButton.setTitle("0.")
            return
        }

        selectedButton.setTitle(text + ".")
    }

    func getLastInputValue() -> String {
        guard let text = inputManager?.selectedButton?.title(for: .normal)
            else { return "" }

        if text.count > 0 {
            let lastIndex = text.index(before: text.endIndex)
            return String(text[lastIndex])
        }

        return ""
    }
}

// MARK: - Meterial Picker
extension CalculatorViewController: MeterialPickerDelegate, MeterialSearchDelegate {

    func selectMeterial(name: String) {
        guard let selectedButton = inputManager?.selectedButton else {
            return
        }
        selectedButton.setTitle(name)
    }

    func openMeterialSearchView() {
        meterialModeButton.snp.remakeConstraints { (make) in
            make.top.equalTo(titleView).offset(44)
            make.left.equalTo(titleView).offset(16)
        }
        meterialSearchView.isHidden = false
        mySearchView.searchTextField.becomeFirstResponder()
    }

    @objc func closeMeterialSearchView() {
        meterialModeButton.snp.remakeConstraints { (make) in
            make.top.equalTo(titleView).offset(48)
            make.left.equalTo(titleView).offset(16)
        }
        meterialSearchView.isHidden = true
        self.view.endEditing(true)
    }

    func closeSearchView() {
        closeMeterialSearchView()
    }
}
