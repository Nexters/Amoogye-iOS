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

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldManager?.focusOutAll()
    }

    func setupButtonStyle(_ buttons: UIButton...) {
        for button in buttons {
            button.layer.cornerRadius = 6
        }
    }

}
