//
//  GetCountForNewToolViewController.swift
//  Amoogye
//
//  Created by 임수현 on 30/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class GetCountForNewToolViewController: UIViewController {

    var toolNameInput: String?
    var selectedCriteriaTool: MeasuringTool?
    var measuringToolManager: RealmMeasuringToolManager?

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var numericKeyboardView: NumericKeyboardView!

    override func viewDidLoad() {
        super.viewDidLoad()

        numericKeyboardView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToComplete" {
            // 다음 컨트롤러에 데이터 전달
            let destination = segue.destination as! CompleteNewToolViewController
            let inputCount = Double(countLabel.text!)

            guard let criteriaTool = selectedCriteriaTool, let newToolName = toolNameInput, let measuringCount = inputCount else {
                return
            }

            destination.newMeasuringTool = MeasuringTool(toolType: .living, unitType: criteriaTool.unitType, name: newToolName, quantity: criteriaTool.quantity * measuringCount, isOn: true)
        }
    }

    @IBAction func backButtonClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func closeButtonClick(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension GetCountForNewToolViewController: NumericKeyboardDelegate {
    func inputNumber(number newValue: String) {
        guard let countText = countLabel.text else {
            return
        }

        if countText == "0" {
            countLabel.text = newValue
        } else {
            countLabel.text = countText + newValue
        }
    }

    func deleteValue() {
        guard let countText = countLabel.text else {
            return
        }

        if countText.count > 1 {
            let end = countText.index(before: countText.endIndex)
            countLabel.text = String(countText[..<end])
        } else {
            countLabel.text = "0"
        }
    }

    func inputDot() {
        guard let countText = countLabel.text else {
            return
        }

        countLabel.text = countText + "."
    }

    func getLastInputValue() -> String {
        guard let countText = countLabel.text else {
            return ""
        }

        let lastIndex = countText.index(before: countText.endIndex)
        return String(countText[lastIndex])
    }
}
