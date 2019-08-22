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
    var textFieldManager: CustomTextfieldManager?
    var calculatorMode = CalculatorMode.MeterialOnly

    let titleView: UIView = UIView()
    let changeView: UIView = UIView()
    let keyboardView: UIView = UIView()

    let tipButton: UIButton = UIButton()
    let historyButton: UIButton = UIButton()
    let meterialModeButton: UIButton = UIButton()
    let plusLabel: UILabel = UILabel()
    let portionModeButton: UIButton = UIButton()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}
