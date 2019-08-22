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
    
    // MARK: - UI
    var textFieldBeingEdited: UITextField?

    // MARK: - Method
    func setItemList(_ itemList: [String]) {
        self.itemList = itemList
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
        if itemList != nil {
            return itemList![row]
        } else {
            return ""
        }
    }
}
