//
//  CalculatorViewController.swift
//  Amoogye
//
//  Created by 임수현 on 13/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit

class CalculatorViewController: UIViewController {

    var textFieldManager: CustomTextfieldManager?
    var calculatorMode = CalculatorMode.MeterialOnly

    enum CalculatorMode {
        case MeterialOnly, PortionOnly, Both
    }

    @IBOutlet weak var portionModeButton: UIButton!
    @IBOutlet weak var meterialModeButton: UIButton!
    @IBOutlet weak var plusLabel: UILabel!

    @IBOutlet weak var srcPortionView: UIView!  // 인원
    @IBOutlet weak var srcQuantityView: UIView! // 재료
    @IBOutlet weak var srcMeterialView: UIView! // 재료 - 무게
    @IBOutlet weak var dstPortionView: UIView!  // 인원
    @IBOutlet weak var dstToolView: UIView!     // 재료

    @IBOutlet weak var srcPortionTextField: CustomTextField!
    @IBOutlet weak var srcQuantityTextField: CustomTextField!
    @IBOutlet weak var srcUnitTextField: CustomTextField!
    @IBOutlet weak var srcMeterialTextField: CustomTextField!

    @IBOutlet weak var dstPortionTextField: CustomTextField!
    @IBOutlet weak var dstToolTextField: CustomTextField!

    @IBOutlet weak var changeButton: UIButton!

    @IBOutlet weak var keyboardView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldManager = CustomTextfieldManager(srcPortionTextField, srcQuantityTextField, srcUnitTextField, srcMeterialTextField, dstPortionTextField, dstToolTextField)
        setupButtonStyle(changeButton)
        showMeterialViewOnly()
        hideWeigthMeterialView()
        showNumericKeyboard()
        srcQuantityTextField.focusOn()
        textFieldManager?.focusOutAll(except: srcQuantityTextField)
    }

    @IBAction func clickMeterialMode(_ sender: UIButton) {
        switch calculatorMode {
        case .MeterialOnly:
            showPortionViewOnly()
        case .PortionOnly:
            showBothView()
        case .Both:
            showPortionViewOnly()
        }
    }

    @IBAction func clickPortionMode(_ sender: Any) {
        switch calculatorMode {
        case .MeterialOnly:
            showBothView()
        case .PortionOnly:
            showMeterialViewOnly()
        case .Both:
            showMeterialViewOnly()
        }
    }

    @IBAction func clickNumericTextField(_ sender: Any) {
        for subview in keyboardView.subviews {
            subview.removeFromSuperview()
        }
        showNumericKeyboard()
    }

    @IBAction func clickMeterialTextField(_ sender: Any) {
        for subview in keyboardView.subviews {
            subview.removeFromSuperview()
        }
        showMeterialPicker()
    }

    @IBAction func clickChangeButton(_ sender: Any) {

    }

    @IBAction func clickTestButton(_ sender: Any) {
        if srcMeterialView.isHidden {
            showWeightMeterialView()
        } else {
            hideWeigthMeterialView()
        }
    }

    func setupButtonStyle(_ buttons: UIButton...) {
        for button in buttons {
            button.layer.cornerRadius = 6
        }
    }

    func showMeterialViewOnly() {
        calculatorMode = .MeterialOnly

        meterialModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        portionModeButton.setTitleColor(UIColor.amLightBlueGrey, for: .normal)
        plusLabel.textColor = UIColor.amLightBlueGrey

        dstToolView.isHidden = false

        srcPortionView.isHidden = true
        dstPortionView.isHidden = true
    }

    func showPortionViewOnly() {
        calculatorMode = .PortionOnly
        meterialModeButton.setTitleColor(UIColor.amLightBlueGrey, for: .normal)
        portionModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        plusLabel.textColor = UIColor.amLightBlueGrey

        dstToolView.isHidden = true

        srcPortionView.isHidden = false
        dstPortionView.isHidden = false
    }

    func showBothView() {
        calculatorMode = .Both

        meterialModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        portionModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        plusLabel.textColor = UIColor.amDarkBlueGrey

        dstToolView.isHidden = false

        srcPortionView.isHidden = false
        dstPortionView.isHidden = false
    }

    func showWeightMeterialView() {
        srcMeterialView.isHidden = false
    }

    func hideWeigthMeterialView() {
        srcMeterialView.isHidden = true
    }

    func showNumericKeyboard() {
        let numericKeyboardView = NumericKeyboardView()
        keyboardView.addSubview(numericKeyboardView)

        numericKeyboardView.snp.makeConstraints { (make) in
            make.top.equalTo(keyboardView.snp.top)
        }
        numericKeyboardView.snp.makeConstraints { (make) in
            make.bottom.equalTo(keyboardView.snp.bottom)
        }
        numericKeyboardView.snp.makeConstraints { (make) in
            make.left.equalTo(keyboardView.snp.left)
        }
        numericKeyboardView.snp.makeConstraints { (make) in
            make.right.equalTo(keyboardView.snp.right)
        }

        numericKeyboardView.delegate = self
    }

    func showMeterialPicker() {
        let meterialPickerView = MeterialPickerView()
        keyboardView.addSubview(meterialPickerView)

        meterialPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(keyboardView.snp.top)
        }
        meterialPickerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(keyboardView.snp.bottom)
        }
        meterialPickerView.snp.makeConstraints { (make) in
            make.left.equalTo(keyboardView.snp.left)
        }
        meterialPickerView.snp.makeConstraints { (make) in
            make.right.equalTo(keyboardView.snp.right)
        }

        meterialPickerView.delegate = self
    }
}

extension CalculatorViewController: NumericKeyboardDelegate {
    func inputNumber(number newValue: String) {
        guard let textField = textFieldManager?.focusedTextField else {
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
        guard let textField = textFieldManager?.focusedTextField else {
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
        guard let textField = textFieldManager?.focusedTextField else {
            return
        }
        guard let text = textField.text else {
            return
        }
        textField.text = text + "."
    }

    func getLastInputValue() -> String {
        guard let textField = textFieldManager?.focusedTextField else {
            return ""
        }
        guard let text = textField.text else {
            return ""
        }
        let lastIndex = text.index(before: text.endIndex)
        return String(text[lastIndex])
    }
}

extension CalculatorViewController: MeterialPickerDelegate {
    func selectMeterial(row: Int, name: String) {
        srcMeterialTextField.text = name
    }

    func meterialSearchViewOpen() {

    }

    func meterialSearchViewClose() {

    }

}
