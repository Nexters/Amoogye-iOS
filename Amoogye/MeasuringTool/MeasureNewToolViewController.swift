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

    // MARK: - 이전 segue에서 받은 데이터
    var toolNameInput: String?

    // MARK: - 계량도구 추가에 이용할 데이터
    var toolList: [MeasuringTool]?
    var selectedCriteriaTool: MeasuringTool?
    var measuringCount: String?

    // MARK: - UI Outlet
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var newToolNameLabel: UILabel!

    @IBOutlet weak var toolSelectionField: UITextField!
    @IBOutlet weak var measuringCountIntLabel: UITextField!
    @IBOutlet weak var measuringCountFloatLabel: UITextField!

    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNewToolNameLabel()
        loadToolList()
        setupInitMeasuring()
        setupNextButton()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToComplete" {

            // 다음 컨트롤러에 데이터 전달
            if let destination = segue.destination as? CompleteNewToolViewController {
                destination.newMeasuringTool = measuringToolManager?.newMeasuringTool(name: newToolNameLabel.text!, criteriaTool: selectedCriteriaTool!, count: measuringCount!)
            }
        }
    }

    // MARK: - 버튼 동작 함수
    @IBAction func clickNextButton(_ sender: UIButton) {
        self.selectedCriteriaTool = measuringToolManager?.getMeasuringTool(toolSelectionField.text!)
        self.measuringCount = measuringCountIntLabel.text! + "." + measuringCountFloatLabel.text!

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

// MARK: - 초기값 세팅 함수
extension MeasureNewToolViewController {
    private func setupNewToolNameLabel() {
        self.newToolNameLabel.text = self.toolNameInput
    }

    private func setupInitMeasuring() {
        self.toolSelectionField.text = toolList?.first?.name
        self.measuringCountIntLabel.text = "1"
        self.measuringCountFloatLabel.text = "0"
    }

    private func loadToolList() {
        self.toolList = measuringToolManager?.getUsingOnLivingMeasuringToolList()
    }
}
