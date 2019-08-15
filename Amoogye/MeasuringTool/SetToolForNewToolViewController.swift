//
//  SetToolForNewToolViewController.swift
//  Amoogye
//
//  Created by 임수현 on 30/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class SetToolForNewToolViewController: UIViewController {
    var measuringToolManager: RealmMeasuringToolManager?

    var toolNameInput: String?
    var selectedCriteriaTool: MeasuringTool?
    var toolList: [MeasuringTool]?

    @IBOutlet weak var toolLabel: UILabel!
    @IBOutlet weak var toolPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        toolPicker.dataSource = self
        toolPicker.delegate = self

        toolList = measuringToolManager?.getUsingOnMeasuringToolList()
        toolLabel.text = toolList!.first?.name
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToGetCount" {
            // 다음 컨트롤러에 데이터 전달
            let destination = segue.destination as! GetCountForNewToolViewController
            destination.toolNameInput = toolNameInput
            destination.selectedCriteriaTool = measuringToolManager?.getMeasuringTool(toolLabel.text!)
        }
    }

    @IBAction func backButtonClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func closeButtonClick(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}

extension SetToolForNewToolViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.toolList?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.toolList?[row].name
    }
}

extension SetToolForNewToolViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        toolLabel.text = self.toolList?[row].name
    }
}
