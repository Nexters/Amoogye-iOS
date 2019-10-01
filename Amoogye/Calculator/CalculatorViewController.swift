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

    var currentMode: CalculatorMode = .Both
    var inputManager: CustomInputButtonManager?
    var calculatorMode = CalculatorMode.MeterialOnly

    let maxRangeNotice: String = "숫자는 9,999까지 입력할 수 있습니다."
    let decimalPointNotice: String = "숫자는 소수점 첫째자리까지 입력할 수 있습니다."

    var gapButtonToButton: Int = 8
    var gapButtonToLabel: Int = 6
    var gapLabelToButton: Int = 10

    let titleView: UIView = UIView()
    let changeView: UIView = UIView()
    let keyboardView: UIView = UIView()
    let searchView: UIView = UIView()

    let tipButton: UIButton = UIButton()
    let historyButton: UIButton = UIButton()
    let meterialModeButton: UIButton = UIButton()
    let plusLabel: UILabel = UILabel()
    let portionModeButton: UIButton = UIButton()

    let noticeLabel: UILabel = UILabel()
    let srcView: UIView = UIView()
    let dstView: UIView = UIView()
    let changeButton: UIButton = UIButton()
    let changeLineView: UIView = UIView()

    let srcPortionView: UIView = UIView()   // (인원 수) 명 기준
    let srcQuantityView: UIView = UIView()  // (양)(단위)
    let srcMeterialView: UIView = UIView()  // 의 (재료)
    let srcFromView: UIView = UIView()      // 를

    let dstPortionView: UIView = UIView()   // (인원 수) 명 기준
    let dstToolView: UIView = UIView()      // (도구)
    let dstToView: UIView = UIView()        // 으로

    let srcPortionInput: CustomInputButton = CustomInputButton()
    let srcPortionLabel: UILabel = UILabel() // ~명 기준
    let srcQuantityInput: CustomInputButton = CustomInputButton()
    let srcUnitInput: CustomInputButton = CustomInputButton()
    let srcForLabel: UILabel = UILabel()    // ~의
    let srcMeterialInput: CustomInputButton = CustomInputButton()
    let srcFromLabel: UILabel = UILabel()   // ~를

    let dstPortionInput: CustomInputButton = CustomInputButton()
    let dstPortionLabel: UILabel = UILabel() // ~명 기준
    let dstToolInput: CustomInputButton = CustomInputButton()
    let dstToLabel: UILabel = UILabel()     // ~으로

    let searchLineView: UILabel = UILabel()
    let meterialSearchView: MeterialSearchView = MeterialSearchView()

    var calculator: Calculator?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupInput()
        setupModeButton()
    }

    @objc func clickNumericInputButton() {
        showNumericKeyboard()
    }
    @objc func clickMeterialInputButton() {
        showMeterialPicker()
    }

    private func setupInput() {
        inputManager = CustomInputButtonManager(srcPortionInput, srcQuantityInput, srcUnitInput, srcMeterialInput, dstPortionInput, dstToolInput)
        inputManager?.focusOn(button: srcQuantityInput)

        // numeric
        srcPortionInput.addTarget(self, action: #selector(clickNumericInputButton), for: .touchUpInside)
        srcQuantityInput.addTarget(self, action: #selector(clickNumericInputButton), for: .touchUpInside)
        dstPortionInput.addTarget(self, action: #selector(clickNumericInputButton), for: .touchUpInside)

        // meterial
        srcMeterialInput.addTarget(self, action: #selector(clickMeterialInputButton), for: .touchUpInside)
    }

    private func setupModeButton() {
        meterialModeButton.addTarget(self, action: #selector(clickMeterialButton), for: .touchUpInside)
        portionModeButton.addTarget(self, action: #selector(clickPortionButton), for: .touchUpInside)
    }
}
