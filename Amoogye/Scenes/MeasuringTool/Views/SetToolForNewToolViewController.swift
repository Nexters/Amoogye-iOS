//
//  SetToolForNewToolViewController.swift
//  Amoogye
//
//  Created by 임수현 on 30/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class SetToolForNewToolViewController: UIViewController {

    let toolList = ["햇반통", "배라스푼", "종이컵", "소주잔", "밥숟갈"]

    @IBOutlet weak var toolLabel: UILabel!
    @IBOutlet weak var toolPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        toolPicker.dataSource = self
        toolPicker.delegate = self
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
        return toolList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return toolList[row]
    }
}

extension SetToolForNewToolViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        toolLabel.text = toolList[row]
    }
}
