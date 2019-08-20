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

    }
    @objc func showToolKeyboard() {
        print("도구키보드")
        hideRecentKeyboard()

    }
}

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

// MARK: - Layout
extension CalculatorViewController {
    // MARK: - 최상위 뷰
    func setupViewLayout() {
        // Add Subviews
        self.view.addSubview(titleView)
        self.view.addSubview(changeView)
        self.view.addSubview(keyboardView)

        // Setup Subviews Attributes
        setupTitleView()
        setupChangeView()
        setupKeyboardView()
    }

    // MARK: - 하위 뷰
    func setupTitleView() {
        // My Constraints
        titleView.snp.makeConstraints { (titleView) in
            titleView.top.equalTo(self.view.safeAreaLayoutGuide)
            titleView.left.equalTo(self.view.safeAreaLayoutGuide)
            titleView.right.equalTo(self.view.safeAreaLayoutGuide)
            titleView.height.equalTo(90)
        }

        // Add Subviews
        titleView.addSubview(tipButton)
        titleView.addSubview(historyButton)
        titleView.addSubview(meterialModeButton)
        titleView.addSubview(plusLabel)
        titleView.addSubview(portionModeButton)

        // Setup Subviews Attributes
        setupTipButton()
        setupHistoryButton()
        setupMeterialModeButton()
        setupPlusLabel()
        setupPortionModeButton()
    }

    func setupChangeView() {
        // Setup My Attributes

        // My Constraints
        changeView.snp.makeConstraints { (changeView) in
            changeView.top.equalTo(titleView.snp.bottom)
            changeView.left.equalTo(self.view.safeAreaLayoutGuide)
            changeView.right.equalTo(self.view.safeAreaLayoutGuide)
            changeView.height.equalTo(238)
        }

        // Add Subviews
        changeView.addSubview(notiLabel)
        changeView.addSubview(srcViews)
        changeView.addSubview(dstViews)
        changeView.addSubview(changeButton)
        changeView.addSubview(lineView)

        // Setup Subviews Attributes
        setupNotiLabel()
        setupSrcViews()
        setupDstViews()
        setupChangeButton()
        setupLineView()
    }

    func setupKeyboardView() {
        // Setup My Attributes

        // My Constraints
        keyboardView.snp.makeConstraints { (make) in
            make.top.equalTo(changeView.snp.bottom)
            make.left.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    // MARK: - TitleView
    func setupTipButton() {
        // Setup My Attributes
        tipButton.setImage(UIImage(named: "tip"), for: .normal)

        // My Constraints
        tipButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.top).offset(20)
            make.right.equalTo(titleView.snp.right).offset(-16)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }

    func setupHistoryButton() {
        // Setup My Attributes
        historyButton.setImage(UIImage(named: "history"), for: .normal)

        // My Constraints
        historyButton.snp.makeConstraints { (make) in
            make.top.equalTo(tipButton.snp.top)
            make.right.equalTo(tipButton.snp.left).offset(-24)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }

    func setupMeterialModeButton() {
        // Setup My Attributes
        meterialModeButton.setTitle("재료", for: .normal)
        meterialModeButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        meterialModeButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)

        // My Constraints
        meterialModeButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleView).offset(48)
            make.left.equalTo(titleView).offset(16)
        }
    }

    func setupPlusLabel() {
        // Setup My Attributes
        plusLabel.text = "+"
        plusLabel.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.2)
        plusLabel.font = .systemFont(ofSize: 24, weight: .bold)

        // My Constraints
        plusLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(meterialModeButton.snp.centerY)
            make.left.equalTo(meterialModeButton.snp.right).offset(8)
        }
    }

    func setupPortionModeButton() {
        // Setup My Attributes
        portionModeButton.setTitle("인원", for: .normal)
        portionModeButton.setTitleColor(UIColor.amDarkBlueGreyWithOpacity(opacity: 0.2), for: .normal)
        portionModeButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)

        // My Constraints
        portionModeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(meterialModeButton.snp.centerY)
            make.left.equalTo(plusLabel.snp.right).offset(9)
        }
    }

    // MARK: - ChangeView
    func setupNotiLabel() {
        notiLabel.text = "숫자는 9,999까지 입력할 수 있습니다."
        notiLabel.textColor = UIColor.amOrangeyRed
        notiLabel.font = .systemFont(ofSize: 12)

        notiLabel.snp.makeConstraints { (make) in
            make.top.equalTo(changeView).offset(15)
            make.left.equalTo(changeView).offset(16)
        }
    }

    func setupSrcViews() {
        changeView.addSubview(srcPortionView)
        changeView.addSubview(srcQuantityView)
        changeView.addSubview(srcMeterialView)
        changeView.addSubview(srcFromView)

        setupSrcPortionView()
        setupSrcQuantityView()
        setupSrcMeterialView()
        setupSrcFromView()

        srcViews.snp.makeConstraints { (make) in
            make.top.equalTo(notiLabel.snp.bottom).offset(8)
            make.leading.equalTo(notiLabel)
            make.height.equalTo(36)
        }
    }

    func setupDstViews() {
        changeView.addSubview(dstPortionView)
        changeView.addSubview(dstToolView)
        changeView.addSubview(dstToView)

        setupDstPortionView()
        setupDstToolView()
        setupDstToView()

        dstViews.snp.makeConstraints { (make) in
            make.top.equalTo(srcViews.snp.bottom).offset(24)
            make.leading.equalTo(srcViews)
            make.height.equalTo(36)
        }
    }

    func setupSrcPortionView() {
        // Add Subviews
        srcPortionView.addSubview(srcPortionInput)
        srcPortionView.addSubview(srcPortionLabel)

        // Setup Subviews Attributes
        setupSrcPortionInput()
        setupSrcPortionLabel()

        // My Constraints6
        srcPortionView.snp.makeConstraints { (make) in
            make.top.equalTo(srcViews)
            make.left.equalTo(srcViews)
            make.height.equalTo(srcViews)
            make.width.equalTo(srcPortionInput.bounds.width + srcPortionLabel.bounds.width + CGFloat(gapButtonLabel + gapLabelButton))
        }
    }

    func setupSrcQuantityView() {
        // Add Subviews
        srcQuantityView.addSubview(srcQuantityInput)
        srcQuantityView.addSubview(srcUnitInput)

        // Setup Subviews Contraints
        setupSrcQuantityInput()
        setupSrcUnitInput()

        // My Constraints
        srcQuantityView.snp.makeConstraints { (make) in
            make.top.equalTo(srcPortionView)
            make.left.equalTo(srcPortionView.snp.right)
            make.height.equalTo(srcPortionView)
            make.width.equalTo(srcQuantityInput.bounds.width + srcUnitInput.bounds.width + CGFloat(gapButtonButton + gapButtonLabel))
        }
    }

    func setupSrcMeterialView() {
        // Add Subviews
        srcMeterialView.addSubview(srcForLabel)
        srcMeterialView.addSubview(srcMeterialInput)

        // Setup Subviews Contraints
        setupSrcForLabel()
        setupSrcMeterialInput()

        // My Constraints
        srcMeterialView.snp.makeConstraints { (make) in
            make.top.equalTo(srcQuantityView)
            make.left.equalTo(srcQuantityView.snp.right)
            make.height.equalTo(srcQuantityView)
            make.width.equalTo(srcForLabel.bounds.width + srcMeterialInput.bounds.width + CGFloat(gapLabelButton + gapButtonLabel))
        }
    }

    func setupSrcFromView() {
        // Setup My Attributes

        // Add Subviews
        srcFromView.addSubview(srcFromLabel)

        // Setup Subviews Contraints
        setupSrcFromLabel()

        // My Constraints
        srcFromView.snp.makeConstraints { (make) in
            make.centerY.equalTo(srcMeterialView)
            make.left.equalTo(srcMeterialView.snp.right)
            make.height.equalTo(srcMeterialView)
            make.width.equalTo(srcFromLabel.bounds.width)
        }
    }

    func setupDstPortionView() {
        // Setup My Attributes

        // Add Subviews
        dstPortionView.addSubview(dstPortionInput)
        dstPortionView.addSubview(dstPortionLabel)

        // Setup Subviews Contraints
        setupDstPortionInput()
        setupDstPortionLabel()

        // My Constraints
        dstPortionView.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(dstViews)
            make.width.equalTo(dstPortionInput.bounds.width + dstPortionLabel.bounds.width + CGFloat(gapButtonLabel + gapLabelButton))
        }
    }

    func setupDstToolView() {
        // Setup My Attributes

        // Add Subviews
        dstToolView.addSubview(dstToolInput)

        // Setup Subviews Contraints
        setupDstToolInput()

        // My Constraints
        dstToolView.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(dstViews)
            make.left.equalTo(dstPortionView.snp.right)
            make.width.equalTo(dstToolInput.bounds.width + CGFloat(gapButtonLabel))
        }
    }

    func setupDstToView() {
        // Setup My Attributes

        // Add Subviews
        dstToView.addSubview(dstToLabel)

        // Setup Subviews Contraints
        setupDstToLabel()

        // My Constraints
        dstToView.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(dstViews)
            make.left.equalTo(dstToolView.snp.right)
            make.width.equalTo(dstToLabel)
        }
    }

    // MARK: - * ChangeView Details
    // MARK: SrcPortionView
    func setupSrcPortionInput() {
        // Setup My Attributes
        srcPortionInput.setTitle("1")

        // My Constraints
        srcPortionInput.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(srcPortionView)
        }
    }

    func setupSrcPortionLabel() {   // ~명 기준
        // Setup My Attributes
        srcPortionLabel.text = "명 기준"
        srcPortionLabel.font = .systemFont(ofSize: 20)
        srcPortionLabel.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)
        srcPortionLabel.sizeToFit()

        // My Constraints
        srcPortionLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(srcPortionView)
            make.left.equalTo(srcPortionInput.snp.right).offset(gapButtonLabel)
        }
    }

    // MARK: - SrcQuantityView
    func setupSrcQuantityInput() {
        // Setup My Attributes
        srcQuantityInput.setTitle("")

        // My Constraints
        srcQuantityInput.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(srcQuantityView)
        }
    }

    func setupSrcUnitInput() {
        // Setup My Attributes
        srcUnitInput.setTitle("ml")

        // My Constraints
        srcUnitInput.snp.makeConstraints { (make) in
            make.centerY.equalTo(srcQuantityInput)
            make.left.equalTo(srcQuantityInput.snp.right).offset(gapButtonButton)
        }
    }

    // MARK: - SrcMeterialView
    func setupSrcForLabel() {   // ~의
        // Setup My Attributes
        srcForLabel.text = "의"
        srcForLabel.font = .systemFont(ofSize: 20)
        srcForLabel.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)
        srcForLabel.sizeToFit()

        // My Constraints
        srcForLabel.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(srcMeterialView)
        }
}

    func setupSrcMeterialInput() {
        // Setup My Attributes
        srcMeterialInput.setTitle("베이킹파우더")

        // My Constraints
        srcMeterialInput.snp.makeConstraints { (make) in
            make.centerY.equalTo(srcForLabel)
            make.left.equalTo(srcForLabel.snp.right).offset(gapLabelButton)
        }
    }

    // MARK: - SrcFromView
    func setupSrcFromLabel() {  // ~를
        // Setup My Attributes
        srcFromLabel.text = "를"
        srcFromLabel.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)
        srcFromLabel.font = .systemFont(ofSize: 20)
        srcFromLabel.sizeToFit()

        // My Constraints
        srcFromLabel.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(srcFromView)
        }
    }

    // MARK: - DstView
    func setupDstPortionInput() {
        // Setup My Attributes
        dstPortionInput.setTitle("1")

        // My Constraints
        dstPortionInput.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(dstPortionView)
        }
    }

    func setupDstPortionLabel() {   // ~명 기준
        // Setup My Attributes
        dstPortionLabel.text = "명 기준"
        dstPortionLabel.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)
        dstPortionLabel.font = .systemFont(ofSize: 20)
        dstPortionLabel.sizeToFit()

        // My Constraints
        dstPortionLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dstPortionView)
            make.left.equalTo(dstPortionInput.snp.right).offset(gapButtonLabel)
        }
    }

    func setupDstToolInput() {
        // Setup My Attributes
        dstToolInput.setTitle("컵")

        // My Constraints
        dstToolInput.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(dstToolView)
        }
    }

    func setupDstToLabel() {   // ~으로
        // Setup My Attributes
        dstToLabel.text = "으로"
        dstToLabel.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)
        dstToLabel.font = .systemFont(ofSize: 20)
        dstToLabel.sizeToFit()

        // My Constraints
        dstToLabel.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(dstToView)
        }
    }

    func setupChangeButton() {
        // Setup My Attributes
        changeButton.setTitle("바꾸면", for: .normal)
        changeButton.setTitleColor(UIColor.white, for: .normal)
        changeButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        changeButton.backgroundColor = UIColor.amOrangeyRed
        changeButton.layer.cornerRadius = 6

        // My Constraints
        changeButton.snp.makeConstraints { (make) in
            make.top.equalTo(dstViews.snp.bottom).offset(24)
            make.leading.equalTo(changeView).offset(16)
            make.trailing.equalTo(changeView).offset(-16)
            make.height.equalTo(60)
        }
    }

    func setupLineView() {
        // Setup My Attributes
        lineView.backgroundColor = UIColor.amIceBlue

        // My Constraints
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(changeButton.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalTo(changeView)
            make.height.equalTo(4)
        }
    }
}
