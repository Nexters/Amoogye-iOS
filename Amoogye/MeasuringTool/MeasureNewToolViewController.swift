//
//  MeasureNewToolViewController.swift
//  Amoogye
//
//  Created by 임수현 on 30/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeasureNewToolViewController: UIViewController {
    var measuringToolManager: RealmMeasuringToolManager?

    var toolNameInput: String?
    var selectedCriteriaTool: MeasuringTool?
    var toolList: [MeasuringTool]?
    var countLabel: String?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newToolNameLabel: UILabel!
    @IBOutlet weak var toolSelectionField: UITextField!
    @IBOutlet weak var measuringCountIntLabel: UITextField!
    @IBOutlet weak var measuringCountFloatLabel: UITextField!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.newToolNameLabel.text = toolNameInput
        toolList = measuringToolManager?.getUsingOnMeasuringToolList()
//        newToolNameLabel.text = toolList!.first?.name
        setupNextButton()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToComplete" {

            // 다음 컨트롤러에 데이터 전달
            if let destination = segue.destination as? CompleteNewToolViewController {
//                destination.toolNameInput = toolNameInput
            }
        }
    }

    @IBAction func clickNextButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToComplete", sender: self)
    }

    @IBAction func backButtonClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func closeButtonClick(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}

// MARK: - 다음 버튼 세팅 함수
extension MeasureNewToolViewController {
    private func setupNextButton() {
        nextButton.layer.cornerRadius = 6
    }
}
