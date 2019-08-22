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
        guard let myself = self.view else { return }

        myself.addSubview(titleView)
        myself.addSubview(changeView)
        myself.addSubview(keyboardView)

        setupTitleView()
        setupChangeView()
        setupKeyboardView()
    }

    // MARK: - Subviews of View
    func setupTitleView() {
        // Define
        let myself = titleView
        let parentView = self.view.safeAreaLayoutGuide

        // Add SubViews
        myself.addSubview(tipButton)
        myself.addSubview(historyButton)
        myself.addSubview(meterialModeButton)
        myself.addSubview(plusLabel)
        myself.addSubview(portionModeButton)

        // Subviews Properties
        setupTipButton()
        setupHistoryButton()
        setupMeterialModeButton()
        setupPlusLabel()
        setupPortionModeButton()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(parentView)
            make.height.equalTo(91)
        }
    }

    func setupChangeView() {
        // Define
        let myself = changeView
        let parentView = self.view.safeAreaLayoutGuide

        // Add SubViews
        myself.addSubview(noticeLabel)
        myself.addSubview(srcView)
        myself.addSubview(dstView)
        myself.addSubview(changeLineView)
        myself.addSubview(changeButton)

        // Subviews Properties
        setupNoticeLabel()
        setupSrcView()
        setupDstView()
        setupChangeLineView()
        setupChangeButton()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.equalTo(parentView).inset(16)
            make.height.equalTo(226)
        }
    }

    func setupKeyboardView() {
        // Define

        // Add SubViews

        // Subviews Properties

        // My Properties

        // My Constraints
    }

    // MARK: - Subviews of Title View
    func setupTipButton() {
        // Define
        let myself = tipButton
        let parentView = self.titleView

        // My Properties
        myself.setImage(UIImage(named: "tip"), for: .normal)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.equalTo(parentView).offset(20)
            make.right.equalTo(parentView).offset(-16)
            make.width.height.equalTo(24)
        }
    }

    func setupHistoryButton() {
        // Define
        let myself = historyButton

        // My Properties
        myself.setImage(UIImage(named: "history"), for: .normal)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.width.height.equalTo(tipButton)
            make.right.equalTo(tipButton.snp.left).offset(-24)
        }
    }

    func setupMeterialModeButton() {
        // Define
        let myself: UIButton = meterialModeButton
        let parentView = self.titleView

        // My Properties
        myself.setTitle("재료", for: .normal)
        myself.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        myself.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.equalTo(parentView).offset(48)
            make.left.equalTo(parentView).offset(16)
            make.height.equalTo(29)
        }
    }

    func setupPlusLabel() {
        // Define
        let myself: UILabel = plusLabel

        // My Properties
        myself.text = "+"
        myself.textColor = UIColor.amDarkBlueGrey
        myself.font = .systemFont(ofSize: 24, weight: .regular)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(meterialModeButton)
            make.left.equalTo(meterialModeButton.snp.right).offset(8)
        }
    }

    func setupPortionModeButton() {
        // Define
        let myself: UIButton = portionModeButton

        // My Properties
        myself.setTitle("인원", for: .normal)
        myself.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        myself.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(meterialModeButton)
            make.left.equalTo(plusLabel.snp.right).offset(8)
        }
    }

    // MARK: - Subviews of Change View
    func setupNoticeLabel() {
        // Define
        let myself: UILabel = noticeLabel
        let parentView = changeView

        // My Properties
        myself.text = "숫자는 9,999까지 입력할 수 있습니다."
        myself.textColor = UIColor.amOrangeyRed
        myself.font = .systemFont(ofSize: 12)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.equalTo(parentView).offset(1)
            make.left.equalTo(parentView)
            make.height.equalTo(15)
        }
    }

    func setupSrcView() {
        // Define
        let myself = srcView
        let parentView = changeView

        // Add SubViews
        myself.addSubview(srcPortionView)
        myself.addSubview(srcQuantityView)
        myself.addSubview(srcMeterialView)
        myself.addSubview(srcFromView)

        // Subviews Properties
        setupSrcPortionView()
        setupSrcQuantityView()
        setupSrcMeterialView()
        setupSrcFromView()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.equalTo(noticeLabel.snp.bottom).offset(8)
            make.left.right.equalTo(parentView)
            make.height.equalTo(36)
        }
    }

    func setupDstView() {

        // Define
        let myself = dstView
        let parentView = changeView

        // Add SubViews
        myself.addSubview(dstPortionView)
        myself.addSubview(dstToolView)
        myself.addSubview(dstToView)

        // Subviews Properties
        setupDstPortionView()
        setupDstToolView()
        setupDstToView()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.equalTo(srcView.snp.bottom).offset(24)
            make.left.right.equalTo(parentView)
            make.height.equalTo(36)
        }
    }

    func setupChangeButton() {
        // Define
        let myself: UIButton = changeButton
        let parentView = changeView

        // My Properties
        myself.setTitle("바꾸면", for: .normal)
        myself.setTitleColor(UIColor.white, for: .normal)
        myself.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        myself.layer.cornerRadius = 6
        myself.backgroundColor = UIColor.amOrangeyRed

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.left.right.equalTo(parentView)
            make.top.equalTo(dstView.snp.bottom).offset(24)
            make.height.equalTo(60)
        }
    }

    func setupChangeLineView() {
        // Define
        let myself = changeLineView
        let parentView = changeView

        // My Properties
        myself.backgroundColor = UIColor.amIceBlue

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.left.equalTo(parentView).offset(-16)
            make.right.equalTo(parentView).offset(16)
            make.bottom.equalTo(parentView)
            make.height.equalTo(4)
        }
    }

    func setupSrcPortionView() {
        // Define
        let myself = srcPortionView
        let parentView = srcView

        // Add SubViews
        myself.addSubview(srcPortionInput)
        myself.addSubview(srcPortionLabel)

        // Subviews Properties
        setupSrcPortionInput()
        setupSrcPortionLabel()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.left.height.equalTo(parentView)
            make.leading.equalTo(srcPortionInput)
            make.trailing.equalTo(srcPortionLabel).offset(gapLabelToButton)
        }
    }

    func setupSrcQuantityView() {
        // Define
        let myself = srcQuantityView
        let parentView = srcView

        // Add SubViews
        myself.addSubview(srcQuantityInput)
        myself.addSubview(srcUnitInput)

        // Subviews Properties
        setupSrcQuantityInput()
        setupSrcUnitInput()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.height.equalTo(parentView)
            make.left.equalTo(srcPortionView.snp.right)
            make.leading.equalTo(srcQuantityInput)
            make.trailing.equalTo(srcUnitInput).offset(gapButtonToLabel)
        }
    }

    func setupSrcMeterialView() {
        // Define
        let myself = srcMeterialView
        let parentView = srcView

        // Add SubViews
        myself.addSubview(srcForLabel)
        myself.addSubview(srcMeterialInput)

        // Subviews Properties
        setupSrcForLabel()
        setupSrcMeterialInput()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.height.equalTo(parentView)
            make.left.equalTo(srcQuantityView.snp.right)
            make.leading.equalTo(srcForLabel)
            make.trailing.equalTo(srcMeterialInput).offset(gapButtonToLabel)
        }
    }

    func setupSrcFromView() {
        // Define
        let myself = srcFromView
        let parentView = srcView

        // Add SubViews
        myself.addSubview(srcFromLabel)

        // Subviews Properties
        setupSrcFromLabel()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.height.equalTo(parentView)
            make.left.equalTo(srcMeterialView.snp.right)
            make.leading.equalTo(srcFromLabel)
            make.trailing.equalTo(srcFromLabel)
        }
    }

    func setupSrcPortionInput() {
        // Define
        let myself: CustomTextField = srcPortionInput
        let parentView = srcPortionView

        // My Properties
        myself.text = "1"

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    func setupSrcPortionLabel() {
        // Define
        let myself: UILabel = srcPortionLabel

        // My Properties
        myself.text = "명 기준"
        myself.font = .systemFont(ofSize: 20)
        myself.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(srcPortionInput)
            make.left.equalTo(srcPortionInput.snp.right).offset(gapButtonToLabel)
        }
    }

    func setupSrcQuantityInput() {
        // Define
        let myself: CustomTextField = srcQuantityInput
        let parentView = srcQuantityView

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    func setupSrcUnitInput() {
        // Define
        let myself = srcUnitInput

        // My Properties
        myself.text = "ml"

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(srcQuantityInput)
            make.left.equalTo(srcQuantityInput.snp.right).offset(gapButtonToButton)
        }
    }

    func setupSrcForLabel() {
        // Define
        let myself = srcForLabel
        let parentView = srcMeterialView

        // My Properties
        myself.text = "의"
        myself.font = .systemFont(ofSize: 20)
        myself.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    func setupSrcMeterialInput() {
        // Define
        let myself = srcMeterialInput

        // My Properties
        myself.text = "물"

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(srcForLabel)
            make.left.equalTo(srcForLabel.snp.right).offset(gapButtonToLabel)
        }
    }

    func setupSrcFromLabel() {
        // Define
        let myself = srcFromLabel
        let parentView = srcFromView

        // My Properties
        myself.text = "을"
        myself.font = .systemFont(ofSize: 20)
        myself.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    func setupDstPortionView() {
        // Define
        let myself = dstPortionView
        let parentView = dstView

        // Add SubViews
        myself.addSubview(dstPortionInput)
        myself.addSubview(dstPortionLabel)

        // Subviews Properties
        setupDstPortionInput()
        setupDstPortionLabel()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.left.height.equalTo(parentView)
            make.leading.equalTo(dstPortionInput)
            make.trailing.equalTo(dstPortionLabel).offset(gapLabelToButton)
        }
    }

    func setupDstToolView() {
        // Define
        let myself = dstToolView
        let parentView = dstView

        // Add SubViews
        myself.addSubview(dstToolInput)

        // Subviews Properties
        setupDstToolInput()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.height.equalTo(parentView)
            make.left.equalTo(dstPortionView.snp.right)
            make.leading.equalTo(dstToolInput)
            make.trailing.equalTo(dstToolInput).offset(gapButtonToLabel)
        }
    }

    func setupDstToView() {
        // Define
        let myself = dstToView
        let parentView = dstView

        // Add SubViews
        myself.addSubview(dstToLabel)

        // Subviews Properties
        setupDstToLabel()

        // My Properties

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.top.height.equalTo(parentView)
            make.left.equalTo(dstToolView.snp.right)
            make.leading.trailing.equalTo(dstToLabel)
        }
    }

    func setupDstPortionInput() {
        // Define
        let myself: CustomTextField = dstPortionInput
        let parentView = dstPortionView

        // My Properties
        myself.text = "1"

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    func setupDstPortionLabel() {
        // Define
        let myself: UILabel = dstPortionLabel

        // My Properties
        myself.text = "명 기준"
        myself.font = .systemFont(ofSize: 20)
        myself.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(dstPortionInput)
            make.left.equalTo(dstPortionInput.snp.right).offset(gapButtonToLabel)
        }
    }

    func setupDstToolInput() {
        // Define
        let myself: CustomTextField = dstToolInput
        let parentView = dstToolView

        // My Properties
        myself.text = "밥숟가락"

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }

    func setupDstToLabel() {
        // Define
        let myself: UILabel = dstToLabel
        let parentView = dstToView

        // My Properties
        myself.text = "으로"
        myself.font = .systemFont(ofSize: 20)
        myself.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)

        // My Constraints
        myself.snp.makeConstraints { (make) in
            make.centerY.left.height.equalTo(parentView)
        }
    }
}
