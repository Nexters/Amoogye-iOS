//
//  CalculatorViewController.swift
//  Amoogye
//
//  Created by 임수현 on 13/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldManager = CustomTextfieldManager(srcPortionTextField,
                                                  srcQuantityTextField,
                                                  srcUnitTextField,
                                                  srcMeterialTextField,
                                                  dstPortionTextField,
                                                  dstToolTextField)
        setupButtonStyle(changeButton)
        showMeterialViewOnly()
        hideWeigthMeterialView()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldManager?.focusOutAll()
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

}
