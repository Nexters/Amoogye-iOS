//
//  MeasuringPickerView.swift
//  Amoogye
//
//  Created by JunHui Kim on 18/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeasuringPickerView: UIView {
    var itemList = [String]()

    var delegate: MeasuringPickerDelegate?

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var itemPicker: UIPickerView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initializeSubviews() {
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else {
            return
        }
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)

        view.frame = self.bounds

        itemPicker.delegate = self
        itemPicker.dataSource = self
    }

    @IBAction func clickConfirmButton(_ sender: UIButton) {

    }
}

extension MeasuringPickerView {
    func setPickerItemList(list: [String]) {
        self.itemList = list
    }
}

extension MeasuringPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemList.count
    }
}

extension MeasuringPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.selectTool(name: itemList[row])
        pickerView.reloadAllComponents()
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemList[row]
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        itemPicker.subviews[1].backgroundColor = UIColor.amIceBlue
        itemPicker.subviews[2].backgroundColor = UIColor.amIceBlue

        let selectedRow = pickerView.selectedRow(inComponent: component)
        var color = UIColor.amDarkBlueGrey

        if row == selectedRow {
            color = UIColor.amOrangeyRed
        }

        return NSAttributedString(string: itemList[row], attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
