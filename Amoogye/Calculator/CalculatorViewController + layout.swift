//
//  CalculatorViewController + layout.swift
//  Amoogye
//
//  Created by 임수현 on 22/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension CalculatorViewController {

    func setupView() {
        guard let myView = self.view else { return }

        myView.addSubview(titleView)
        myView.addSubview(changeView)
        myView.addSubview(keyboardView)
        myView.addSubview(searchView)

        setupTitleView()
        setupChangeView()
        setupKeyboardView()
        setupSearchView()
    }

    // MARK: - Subviews of View
    private func setupTitleView() {
        // Define
        let myView = titleView
        let parentView = self.view.safeAreaLayoutGuide

        // Add SubViews
        myView.addSubview(tipButton)
        myView.addSubview(historyButton)
        myView.addSubview(meterialModeButton)
        myView.addSubview(plusLabel)
        myView.addSubview(portionModeButton)

        // Subviews Properties
        setupTipButton()
        setupHistoryButton()
        setupMeterialModeButton()
        setupPlusLabel()
        setupPortionModeButton()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(parentView)
            make.height.equalTo(91)
        }
    }

    private func setupChangeView() {
        // Define
        let myView = changeView
        let parentView = self.view.safeAreaLayoutGuide

        // Add SubViews
        myView.addSubview(noticeLabel)
        myView.addSubview(srcView)
        myView.addSubview(dstView)
        myView.addSubview(changeLineView)
        myView.addSubview(changeButton)

        // Subviews Properties
        setupNoticeLabel()
        setupSrcView()
        setupDstView()
        setupChangeLineView()
        setupChangeButton()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.equalTo(parentView).inset(16)
            make.height.equalTo(226)
        }
    }

    private func setupKeyboardView() {
        // Define
        let myView = keyboardView
        let parentView = self.view.safeAreaLayoutGuide

        // Add SubViews
        showNumericKeyboard()

        // Subviews Properties

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.equalTo(changeView.snp.bottom)
            make.left.right.bottom.equalTo(parentView)
        }
    }

    private func setupSearchView() {
        // Define
        let myView = searchView
        let parentView = self.view.safeAreaLayoutGuide

        // Add SubViews
        myView.addSubview(searchLineView)
        myView.addSubview(meterialSearchView)

        // Subviews Properties
        setupSearchLineView()
        setupMeterialSearchView()

        // My Properties
        myView.isHidden = true

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.bottom.equalTo(parentView)
        }
    }

    // MARK: - Subviews of Title View
    private func setupTipButton() {
        // Define
        let myView = tipButton
        let parentView = self.titleView

        // My Properties
        myView.setImage(UIImage(named: "tip"), for: .normal)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.equalTo(parentView).offset(20)
            make.right.equalTo(parentView).offset(-16)
            make.width.height.equalTo(24)
        }
    }

    private func setupHistoryButton() {
        // Define
        let myView = historyButton

        // My Properties
        myView.setImage(UIImage(named: "history"), for: .normal)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.width.height.equalTo(tipButton)
            make.right.equalTo(tipButton.snp.left).offset(-24)
        }
    }

    private func setupMeterialModeButton() {
        // Define
        let myView: UIButton = meterialModeButton
        let parentView = self.titleView

        // My Properties
        renderModeButton(button: myView, title: "재료", isSelected: true)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.equalTo(parentView).offset(48)
            make.left.equalTo(parentView).offset(16)
            make.height.equalTo(29)
        }
    }

    private func setupPlusLabel() {
        // Define
        let myView: UILabel = plusLabel

        // My Properties
        myView.text = "+"
        myView.textColor = UIColor.amDarkBlueGrey
        myView.font = .systemFont(ofSize: 24, weight: .regular)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(meterialModeButton)
            make.left.equalTo(meterialModeButton.snp.right).offset(8)
        }
    }

    private func setupPortionModeButton() {
        // Define
        let myView: UIButton = portionModeButton

        // My Properties
        renderModeButton(button: myView, title: "인원", isSelected: true)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(meterialModeButton)
            make.left.equalTo(plusLabel.snp.right).offset(8)
        }
    }

    // MARK: - Subviews of Change View
    private func setupNoticeLabel() {
        // Define
        let myView: UILabel = noticeLabel
        let parentView = changeView

        // My Properties
        myView.textColor = UIColor.amOrangeyRed
        myView.font = .systemFont(ofSize: 12)
        myView.isHidden = true

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.equalTo(parentView).offset(1)
            make.left.equalTo(parentView)
            make.height.equalTo(15)
        }
    }

    private func setupSrcView() {
        // Define
        let myView = srcView
        let parentView = changeView

        // Add SubViews
        myView.addSubview(srcPortionView)
        myView.addSubview(srcQuantityView)
        myView.addSubview(srcMeterialView)
        myView.addSubview(srcFromView)

        // Subviews Properties
        setupSrcPortionView()
        setupSrcQuantityView()
        setupSrcMeterialView()
        setupSrcFromView()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.equalTo(noticeLabel.snp.bottom).offset(8)
            make.left.right.equalTo(parentView)
            make.height.equalTo(36)
        }
    }

    private func setupDstView() {

        // Define
        let myView = dstView
        let parentView = changeView

        // Add SubViews
        myView.addSubview(dstPortionView)
        myView.addSubview(dstToolView)
        myView.addSubview(dstToView)

        // Subviews Properties
        setupDstPortionView()
        setupDstToolView()
        setupDstToView()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.equalTo(srcView.snp.bottom).offset(24)
            make.left.right.equalTo(parentView)
            make.height.equalTo(36)
        }
    }

    private func setupChangeButton() {
        // Define
        let myView: UIButton = changeButton
        let parentView = changeView

        // My Properties
        renderChangeButton(isEnable: false)
        myView.addTarget(self, action: #selector(self.clickChangeButton), for: .touchUpInside)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.left.right.equalTo(parentView)
            make.top.equalTo(dstView.snp.bottom).offset(24)
            make.height.equalTo(60)
        }
    }

    private func setupChangeLineView() {
        // Define
        let myView = changeLineView
        let parentView = changeView

        // My Properties
        myView.backgroundColor = UIColor.amIceBlue

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.left.equalTo(parentView).offset(-16)
            make.right.equalTo(parentView).offset(16)
            make.bottom.equalTo(parentView)
            make.height.equalTo(4)
        }
    }

    // MARK: - * srcView
    private func setupSrcPortionView() {
        // Define
        let myView = srcPortionView
        let parentView = srcView

        // Add SubViews
        myView.addSubview(srcPortionInput)
        myView.addSubview(srcPortionLabel)

        // Subviews Properties
        setupSrcPortionInput()
        setupSrcPortionLabel()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.left.height.equalTo(parentView)
            make.leading.equalTo(srcPortionInput)
            make.trailing.equalTo(srcPortionLabel).offset(gapLabelToButton)
        }
    }

    private func setupSrcQuantityView() {
        // Define
        let myView = srcQuantityView
        let parentView = srcView

        // Add SubViews
        myView.addSubview(srcQuantityInput)
        myView.addSubview(srcUnitInput)

        // Subviews Properties
        setupSrcQuantityInput()
        setupSrcUnitInput()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.height.equalTo(parentView)
            make.left.equalTo(srcPortionView.snp.right)
            make.leading.equalTo(srcQuantityInput)
            make.trailing.equalTo(srcUnitInput).offset(gapButtonToLabel)
        }
    }

    private func setupSrcMeterialView() {
        // Define
        let myView = srcMeterialView
        let parentView = srcView

        // Add SubViews
        myView.addSubview(srcForLabel)
        myView.addSubview(srcMeterialInput)

        // Subviews Properties
        setupSrcForLabel()
        setupSrcMeterialInput()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.height.equalTo(parentView)
            make.left.equalTo(srcQuantityView.snp.right)
            make.leading.equalTo(srcForLabel)
            make.trailing.equalTo(srcMeterialInput).offset(gapButtonToLabel)
        }
    }

    private func setupSrcFromView() {
        // Define
        let myView = srcFromView
        let parentView = srcView

        // Add SubViews
        myView.addSubview(srcFromLabel)

        // Subviews Properties
        setupSrcFromLabel()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.height.equalTo(parentView)
            make.left.equalTo(srcMeterialView.snp.right)
            make.leading.equalTo(srcFromLabel)
            make.trailing.equalTo(srcFromLabel)
        }
    }

    // MARK: ** srcPortionView
    private func setupSrcPortionInput() {
        // Define
        let myView: CustomInputButton = srcPortionInput
        let parentView = srcPortionView

        // My Properties
        myView.setTitle("1", for: .normal)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    private func setupSrcPortionLabel() {
        // Define
        let myView: UILabel = srcPortionLabel

        // My Properties
        renderChangeViewLabel(label: myView, title: "명 기준")

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(srcPortionInput)
            make.left.equalTo(srcPortionInput.snp.right).offset(gapButtonToLabel)
        }
    }

    // MARK: ** srcQuantityView
    private func setupSrcQuantityInput() {
        // Define
        let myView: CustomInputButton = srcQuantityInput
        let parentView = srcQuantityView

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    private func setupSrcUnitInput() {
        // Define
        let myView = srcUnitInput

        // My Properties
        myView.setTitle("ml", for: .normal)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(srcQuantityInput)
            make.left.equalTo(srcQuantityInput.snp.right).offset(gapButtonToButton)
        }
    }

    // MARK: ** srcMeterialView
    private func setupSrcForLabel() {
        // Define
        let myView: UILabel = srcForLabel
        let parentView = srcMeterialView

        // My Properties
        renderChangeViewLabel(label: myView, title: "의")

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    private func setupSrcMeterialInput() {
        // Define
        let myView = srcMeterialInput

        // My Properties
        myView.setTitle("물", for: .normal)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(srcForLabel)
            make.left.equalTo(srcForLabel.snp.right).offset(gapButtonToLabel)
        }
    }

    // MARK: ** srcFromView
    private func setupSrcFromLabel() {
        // Define
        let myView: UILabel = srcFromLabel
        let parentView = srcFromView

        // My Properties
        renderChangeViewLabel(label: myView, title: "을")

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    // MARK: - * dstView
    private func setupDstPortionView() {
        // Define
        let myView = dstPortionView
        let parentView = dstView

        // Add SubViews
        myView.addSubview(dstPortionInput)
        myView.addSubview(dstPortionLabel)

        // Subviews Properties
        setupDstPortionInput()
        setupDstPortionLabel()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.left.height.equalTo(parentView)
            make.leading.equalTo(dstPortionInput)
            make.trailing.equalTo(dstPortionLabel).offset(gapLabelToButton)
        }
    }

    private func setupDstToolView() {
        // Define
        let myView = dstToolView
        let parentView = dstView

        // Add SubViews
        myView.addSubview(dstToolInput)

        // Subviews Properties
        setupDstToolInput()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.height.equalTo(parentView)
            make.left.equalTo(dstPortionView.snp.right)
            make.leading.equalTo(dstToolInput)
            make.trailing.equalTo(dstToolInput).offset(gapButtonToLabel)
        }
    }

    private func setupDstToView() {
        // Define
        let myView = dstToView
        let parentView = dstView

        // Add SubViews
        myView.addSubview(dstToLabel)

        // Subviews Properties
        setupDstToLabel()

        // My Properties

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.height.equalTo(parentView)
            make.left.equalTo(dstToolView.snp.right)
            make.leading.trailing.equalTo(dstToLabel)
        }
    }

    // MARK: ** dstPortionView
    private func setupDstPortionInput() {
        // Define
        let myView: CustomInputButton = dstPortionInput
        let parentView = dstPortionView

        // My Properties
        myView.setTitle("1", for: .normal)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    private func setupDstPortionLabel() {
        // Define
        let myView: UILabel = dstPortionLabel

        // My Properties
        renderChangeViewLabel(label: myView, title: "명 기준")

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(dstPortionInput)
            make.left.equalTo(dstPortionInput.snp.right).offset(gapButtonToLabel)
        }
    }

    // MARK: ** dstToolView
    private func setupDstToolInput() {
        // Define
        let myView: CustomInputButton = dstToolInput
        let parentView = dstToolView

        // My Properties
        myView.setTitle("밥숟가락", for: .normal)

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    // MARK: ** dstToView
    private func setupDstToLabel() {
        // Define
        let myView: UILabel = dstToLabel
        let parentView = dstToView

        // My Properties
        renderChangeViewLabel(label: myView, title: "으로")

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    // MARK: - Subviews of Search View
    private func setupSearchLineView() {
        // Define
        let myView = searchLineView
        let parentView = searchView

        // My Properties
        myView.backgroundColor = UIColor.amIceBlue

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(parentView)
            make.height.equalTo(4)
        }
    }

    private func setupMeterialSearchView() {
        // Define
        let myView = meterialSearchView
        let parentView = searchView

        // My Properties
        myView.delegate = self

        // My Constraints
        myView.snp.makeConstraints { (make) in
            make.top.equalTo(searchLineView.snp.bottom)
            make.left.right.bottom.equalTo(parentView)
        }
    }
}

extension CalculatorViewController {

    private func renderChangeViewLabel(label: UILabel, title: String) {
        label.text = title
        label.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)
        label.font = .systemFont(ofSize: 20)
    }

    private func renderModeButton(button: UIButton, title: String, isSelected: Bool) {
        button.setTitle(title, for: .normal)

        if isSelected {
            button.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        } else {
            button.setTitleColor(UIColor.amDarkBlueGreyWithOpacity(opacity: 0.2), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 24)
        }
    }

    func renderChangeButton(isEnable: Bool) {
        changeButton.setTitle("바꾸면", for: .normal)
        changeButton.setTitleColor(UIColor.white, for: .normal)
        changeButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        changeButton.layer.cornerRadius = 6

        changeButton.isEnabled = isEnable
        if isEnable {
            changeButton.backgroundColor = UIColor.amOrangeyRed
        } else {
            changeButton.backgroundColor = UIColor.amPaleBlue
        }
    }
}
