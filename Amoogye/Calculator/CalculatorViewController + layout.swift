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

        // Subviews Constraints
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

        // Add SubViews

        // Subviews Constraints

        // My Properties

        // My Constraints
    }

    func setupKeyboardView() {
        // Define

        // Add SubViews

        // Subviews Constraints

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
}
