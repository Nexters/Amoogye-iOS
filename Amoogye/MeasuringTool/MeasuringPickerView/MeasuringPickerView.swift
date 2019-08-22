//
//  MeasuringPickerView.swift
//  Amoogye
//
//  Created by JunHui Kim on 18/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeasuringPickerView: UIPickerView {
    var itemList: [String]? {
        didSet {
            super.delegate = self
            super.dataSource = self
            self.reloadAllComponents()
        }
    }
    var measuringPickerDelegate: MeasuringPickerDelegate?

    @IBOutlet weak var pickerToolBar: UIToolbar!
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
        guard let itemCount = self.itemList?.count else {
            print("Error: [MeasuringPickerView] - itemList is nil")
            return 0
        }
        return itemCount
    }
}

extension MeasuringPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        measuringPickerDelegate?.selectTool(name: itemList![row])
        pickerView.reloadAllComponents()
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemList![row]
    }

    //    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    //
    //        let selectedRow = pickerView.selectedRow(inComponent: component)
    //        var color = UIColor.amDarkBlueGrey
    //
    //        if row == selectedRow {
    //            color = UIColor.amOrangeyRed
    //        }
    //
    //        return NSAttributedString(string: itemList![row], attributes: [NSAttributedString.Key.foregroundColor: color])
    //    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel

        if let v = view as? UILabel {
            label = v
        } else {
            label = UILabel()
        }

        if row == pickerView.selectedRow(inComponent: component) {
            label.textColor = UIColor.amOrangeyRed
        } else {
            label.textColor = UIColor.amDarkBlueGrey
        }
        label.textAlignment = .center

        label.font = UIFont.systemFont(ofSize: 20)

        label.text = self.itemList![row]

        return label
    }
}
