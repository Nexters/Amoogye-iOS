//
//  CalculatorViewController.swift
//  Amoogye
//
//  Created by 임수현 on 18/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit

class CalculatorViewController: UIViewController {

    var inputManager: CustomInputButtonManager?
    var mode: CalculatorMode = .Meterial

    enum CalculatorMode {
        case Meterial, Portion, Both
    }

    var gapButtonButton: Int = 8    // 4 (입력단위 4개 이상일 경우)
    var gapButtonLabel: Int = 6     // 4
    var gapLabelButton: Int = 10    // 8
    var fontSize: Int = 20          // 14 (최대글자 노출시 변경되는 폰트 사이즈)

    let titleView: UIView = UIView()
    let searchView: UIView = UIView()
    let changeView: UIView = UIView()
    let keyboardView: UIView = UIView()
    let meterialSearchView: UIView = UIView()

    // titleView
    let historyButton: UIButton = UIButton()
    let tipButton: UIButton = UIButton()
    let meterialModeButton: UIButton = UIButton()
    let portionModeButton: UIButton = UIButton()
    let plusLabel: UILabel = UILabel()

    // changeView
    let notiLabel: UILabel = UILabel()
    let srcViews: UIView = UIView()
    let dstViews: UIView = UIView()

    // srcView
    let srcPortionView: UIView = UIView()
    let srcQuantityView: UIView = UIView()
    let srcMeterialView: UIView = UIView()
    let srcFromView: UIView = UIView()

    let srcPortionInput: CustomInputButton = CustomInputButton()
    let srcPortionLabel: UILabel = UILabel()
    let srcQuantityInput: CustomInputButton = CustomInputButton()
    let srcUnitInput: CustomInputButton = CustomInputButton()
    let srcForLabel: UILabel = UILabel()
    let srcMeterialInput: CustomInputButton = CustomInputButton()
    let srcFromLabel: UILabel = UILabel()

    // dstView
    let dstPortionView: UIView = UIView()
    let dstToolView: UIView = UIView()
    let dstToView: UIView = UIView()

    let dstPortionInput: CustomInputButton = CustomInputButton()
    let dstPortionLabel: UILabel = UILabel()
    let dstToolInput: CustomInputButton = CustomInputButton()
    let dstToLabel: UILabel = UILabel()

    // change button
    let changeButton: UIButton = UIButton()
    let lineView: UIView = UIView()

    // searchView
    let searchLineView: UIView = UIView()
    let mySearchView: MeterialSearchView = MeterialSearchView()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewLayout()
        setModeButtonSelector()
        setInputButtonSelector()
        setInputManager()
    }
}

// MARK: - Mode
extension CalculatorViewController {
    func setModeButtonSelector() {
        meterialModeButton.addTarget(self, action: #selector(clickMeterialModeButton), for: .touchUpInside)
        portionModeButton.addTarget(self, action: #selector(clickPortionModeButton), for: .touchUpInside)
    }

    @objc func clickMeterialModeButton() {
        switch mode {
        case .Meterial:
            mode = .Portion
            showPortionMode()
        case .Portion:
            mode = .Both
            showBothMode()
        case .Both:
            mode = .Portion
            showPortionMode()
        }
    }

    @objc func clickPortionModeButton() {
        switch mode {
        case .Meterial:
            mode = .Both
            showBothMode()
        case .Portion:
            mode = .Meterial
            showMeterialMode()
        case .Both:
            mode = .Meterial
            showMeterialMode()
        }
    }

    func showMeterialMode() {
        meterialModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        portionModeButton.setTitleColor(UIColor.amDarkBlueGreyWithOpacity(opacity: 0.2), for: .normal)
        plusLabel.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.2)
        hidePortionGroup()
        showQuantityGroup()
    }

    func showPortionMode() {
        meterialModeButton.setTitleColor(UIColor.amDarkBlueGreyWithOpacity(opacity: 0.2), for: .normal)
        portionModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        plusLabel.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.2)
        showPortionGroup()
        hideQuantityGroup()
    }

    func showBothMode() {
        meterialModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        portionModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        plusLabel.textColor = UIColor.amDarkBlueGrey
        showPortionMode()
        showPortionGroup()
    }

    // 모드 별 인터렉션 구현
    func hidePortionGroup() { }
    func showPortionGroup() { }
    func hideQuantityGroup() { }
    func showQuantityGroup() { }
    func hideMeterialGroup() { }  // 부피 단위 선택 시
    func showMeterialGroup() { } // 무게 단위 선택 시
}

// MARK: - Keyboard
extension CalculatorViewController {
    func setInputManager() {
        inputManager = CustomInputButtonManager(srcPortionInput, srcQuantityInput, srcUnitInput, srcMeterialInput, dstPortionInput, dstToolInput)
        inputManager?.focusOut(except: srcQuantityInput)
        showNumericKeyboard()
    }

    func setInputButtonSelector() {
        srcPortionInput.addTarget(self, action: #selector(showNumericKeyboard), for: .touchUpInside)
        srcQuantityInput.addTarget(self, action: #selector(showNumericKeyboard), for: .touchUpInside)
        dstPortionInput.addTarget(self, action: #selector(showNumericKeyboard), for: .touchUpInside)
        srcUnitInput.addTarget(self, action: #selector(showUnitKeyboard), for: .touchUpInside)
        srcMeterialInput.addTarget(self, action: #selector(showMeterialPicker), for: .touchUpInside)
        dstToolInput.addTarget(self, action: #selector(showToolKeyboard), for: .touchUpInside)
    }

    func hideRecentKeyboard() {
        for subview in keyboardView.subviews {
            subview.removeFromSuperview()
        }
    }

    @objc func showNumericKeyboard() {
        print("숫자키보드")
        hideRecentKeyboard()

        let numericKeyboard = NumericKeyboardView()
        numericKeyboard.delegate = self

        keyboardView.addSubview(numericKeyboard)
        numericKeyboard.frame = keyboardView.bounds
    }

    @objc func showUnitKeyboard() {
        print("단위키보드")
        hideRecentKeyboard()

    }

    @objc func showMeterialPicker() {
        print("재료키보드")
        hideRecentKeyboard()

        let meterialPicker = MeterialPickerView()
        meterialPicker.delegate = self

        keyboardView.addSubview(meterialPicker)
        meterialPicker.frame = keyboardView.bounds
    }

    @objc func showToolKeyboard() {
        print("도구키보드")
        hideRecentKeyboard()

    }
}
