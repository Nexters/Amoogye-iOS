//
//  PickerView.swift
//  Amoogye
//
//  Created by JunHui Kim on 22/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class PickerView: UIPickerView {
    // MARK: - Data
    var itemList: [String]? {
        didSet {
            super.delegate = self
            super.dataSource = self
            self.reloadAllComponents()
        }
    }

    var selectedValue: String {
        get {
            if itemList != nil {
                return itemList![selectedRow(inComponent: 0)]
            } else {
                return ""
            }
        }
    }

    var textFieldBeingEdited: UITextField?

    // MARK: - Method
    func setItemList(_ itemList: [String]) {
        self.itemList = itemList
    }

    func setEditingTextField(_ textField: UITextField) {
        self.textFieldBeingEdited = textField
    }

    func setPickerItem(withSelectedItem selectedItem: String) {
        self.selectRow(itemList?.firstIndex(of: selectedItem) ?? 0, inComponent: 0, animated: false)
    }
}

// MARK: - UIPicker Extension
extension PickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let itemCount = self.itemList?.count else {
            print("Error: [PickerView] - itemList is nil")
            return 0
        }
        return itemCount
    }
}

extension PickerView: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let itemList = self.itemList else {
            return ""
        }
        return itemList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var pickerLabel = UILabel()
        if let v = view {
            pickerLabel = v as! UILabel
        }
        pickerLabel.font = UIFont.systemFont(ofSize: 20)
        pickerLabel.textAlignment = .center
        pickerLabel.textColor = UIColor.amDarkBlueGrey

        pickerLabel.text = itemList![row]

        return pickerLabel
    }
}
