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

    @IBOutlet weak var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToComplete" {
            // 다음 컨트롤러에 데이터 전달
            let destination = segue.destination as! CompleteNewToolViewController
            let inputCount = Double(countLabel.text!)

            guard let criteriaTool = selectedCriteriaTool, let newToolName = toolNameInput, let measuringCount = inputCount else {
                return
            }

            let measuringToolManager = MeasuringToolManager()
            destination.newMeasuringTool = measuringToolManager.newMeasuringToolWith(criteriaTool, name: newToolName, measuringCount: measuringCount)
        }
    }

    @IBAction func backButtonClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func closeButtonClick(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func numberClick(_ sender: UIButton) {
        guard let countText = countLabel.text else {
            return
        }

        if countText == "0" {
            countLabel.text = String(sender.tag)
        } else {
            countLabel.text = countText + String(sender.tag)
        }
    }

    @IBAction func deleteNumber (_ sender: UIButton) {
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
}
