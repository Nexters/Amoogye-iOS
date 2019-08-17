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
    enum CalculatorMode {
        case MeterialOnly, PortionOnly, Both
    }

    // MARK: - Instance
    var textFieldManager: CustomTextfieldManager_bak?
    var calculatorMode = CalculatorMode.MeterialOnly

    // MARK: - Outlet
    @IBOutlet weak var portionModeButton: UIButton!
    @IBOutlet weak var meterialModeButton: UIButton!
    @IBOutlet weak var plusLabel: UILabel!

    @IBOutlet weak var srcPortionView: UIView!  // 인원
    @IBOutlet weak var srcQuantityView: UIView! // 재료
    @IBOutlet weak var srcMeterialView: UIView! // 재료 - 무게
    @IBOutlet weak var dstPortionView: UIView!  // 인원
    @IBOutlet weak var dstToolView: UIView!     // 재료

    @IBOutlet weak var srcPortionTextField: CustomTextField_bak!
    @IBOutlet weak var srcQuantityTextField: CustomTextField_bak!
    @IBOutlet weak var srcUnitTextField: CustomTextField_bak!
    @IBOutlet weak var srcMeterialTextField: CustomTextField_bak!

    @IBOutlet weak var dstPortionTextField: CustomTextField_bak!
    @IBOutlet weak var dstToolTextField: CustomTextField_bak!

    @IBOutlet weak var changeButton: UIButton!

    @IBOutlet weak var keyboardView: UIView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // view setup
        showMeterialViewOnly()
        hideWeightMeterialView()
        setupButtonStyle(changeButton)
        showNumericKeyboard()

        // textfield setup
        textFieldManager = CustomTextfieldManager_bak(srcPortionTextField, srcQuantityTextField, srcUnitTextField, srcMeterialTextField, dstPortionTextField, dstToolTextField)
        textFieldManager?.focusOutAll()
        srcQuantityTextField.focusOn()
    }

    // MARK: - Action
    @IBAction func clickMeterialMode(_ sender: UIButton) {
        switch calculatorMode {
        case .MeterialOnly:
            calculatorMode = .PortionOnly
            showPortionViewOnly()

        case .PortionOnly:
            calculatorMode = .Both
            showBothView()

        case .Both:
            calculatorMode = .PortionOnly
            showPortionViewOnly()
        }
    }

    @IBAction func clickPortionMode(_ sender: Any) {
        switch calculatorMode {
        case .MeterialOnly:
            calculatorMode = .Both
            showBothView()

        case .PortionOnly:
            calculatorMode = .MeterialOnly
            showMeterialViewOnly()

        case .Both:
            calculatorMode = .MeterialOnly
            showMeterialViewOnly()
        }
    }

    @IBAction func clickNumericTextField(_ sender: Any) {
        hideExistingKeyboard()
        showNumericKeyboard()
    }

    @IBAction func clickMeterialTextField(_ sender: Any) {
        hideExistingKeyboard()
        showMeterialPicker()
    }

    @IBAction func clickChangeButton(_ sender: Any) {

    }

    @IBAction func clickTestButton(_ sender: Any) {
        if srcMeterialView.isHidden {
            showWeightMeterialView()
        } else {
            hideWeightMeterialView()
        }
    }
}

extension CalculatorViewController {
    // MARK: - setup
    func setModeButtonTitle(isMeterialOn: Bool, isPortionOn: Bool) {
        if isMeterialOn {
            meterialModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        } else {
            meterialModeButton.setTitleColor(UIColor.amLightBlueGrey, for: .normal)
        }

        if isPortionOn {
            portionModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        } else {
            portionModeButton.setTitleColor(UIColor.amLightBlueGrey, for: .normal)
        }

        if isMeterialOn && isPortionOn {
            plusLabel.textColor = UIColor.amDarkBlueGrey
        } else {
            plusLabel.textColor = UIColor.amLightBlueGrey
        }
    }

    func setupButtonStyle(_ buttons: UIButton...) {
        for button in buttons {
            button.layer.cornerRadius = 6
        }
    }

    // MARK: - view
    func showMeterialViewOnly() {
        setModeButtonTitle(isMeterialOn: true, isPortionOn: false)

        dstToolView.isHidden = false
        srcPortionView.isHidden = true
        dstPortionView.isHidden = true
    }

    func showPortionViewOnly() {
        setModeButtonTitle(isMeterialOn: false, isPortionOn: true)

        dstToolView.isHidden = true
        srcPortionView.isHidden = false
        dstPortionView.isHidden = false
    }

    func showBothView() {
        setModeButtonTitle(isMeterialOn: true, isPortionOn: true)

        dstToolView.isHidden = false
        srcPortionView.isHidden = false
        dstPortionView.isHidden = false
    }

    func showWeightMeterialView() {
        srcMeterialView.isHidden = false
    }

    func hideWeightMeterialView() {
        srcMeterialView.isHidden = true
    }

    // MARK: - Keyboard
    func showNumericKeyboard() {
        let numericKeyboardView = NumericKeyboardView()
        keyboardView.addSubview(numericKeyboardView)

        // AutoLayout
        numericKeyboardView.snp.makeConstraints { (make) in
            make.top.equalTo(keyboardView.snp.top)
            make.bottom.equalTo(keyboardView.snp.bottom)
            make.left.equalTo(keyboardView.snp.left)
            make.right.equalTo(keyboardView.snp.right)
        }
        numericKeyboardView.delegate = self
    }

    func showMeterialPicker() {
        let meterialPickerView = MeterialPickerView()
        keyboardView.addSubview(meterialPickerView)

        // AutoLayout
        meterialPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(keyboardView.snp.top)
            make.bottom.equalTo(keyboardView.snp.bottom)
            make.left.equalTo(keyboardView.snp.left)
            make.right.equalTo(keyboardView.snp.right)
        }
        meterialPickerView.delegate = self
    }

    func hideExistingKeyboard() {
        for subview in keyboardView.subviews {
            subview.removeFromSuperview()
        }
    }
}

// MARK: - Numeric Keyboard
extension CalculatorViewController: NumericKeyboardDelegate {
    func inputNumber(number newValue: String) {
        guard let textField = textFieldManager?.focusedTextField, let text = textField.text else { return }

        if text == "0" {
            textField.text = newValue
        } else {
            textField.text = text + newValue
        }
    }

    func deleteValue() {
        guard let textField = textFieldManager?.focusedTextField, let text = textField.text else { return }
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

// MARK: - Meterial Picker
extension CalculatorViewController: MeterialPickerDelegate {
    func selectMeterial(row: Int, name: String) {
        srcMeterialTextField.text = name
    }

    func openMeterialSearchView() {

    }

    func closeMeterialSearchView() {

    }
}
