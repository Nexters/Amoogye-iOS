//
//  PickerView.swift
//  Amoogye
//
//  Created by 임수현 on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class PickerView: UIView {
    weak var delegate: MeterialPickerDelegate?
    let meterialList = ["굴소스", "간장", "소금", "밀가루", "물", "베이킹파우더", "고추장"]

    @IBOutlet weak var defaultOrderButton: UIButton!
    @IBOutlet weak var recentOrderButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!

    // 초기화
    override func draw(_ rect: CGRect) {
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    // 기본 순
    @IBAction func defaultButtonClick(_ sender: Any) {
        defaultOrderButton.setTitleColor(UIColor.black, for: .normal)
        recentOrderButton.setTitleColor(UIColor.lightGray, for: .normal)
    }

    // 최근 사용 순
    @IBAction func recentButtonClick(_ sender: Any) {
        defaultOrderButton.setTitleColor(UIColor.lightGray, for: .normal)
        recentOrderButton.setTitleColor(UIColor.black, for: .normal)
    }

    // 재료 검색
    @IBAction func searchButtonClick(_ sender: Any) {
        print("show search view")
        delegate?.meterialSearchViewOpen()
    }
}

extension PickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return meterialList.count
    }
}

extension PickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return meterialList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.meterialSelected(row: row, title: meterialList[row])
    }
}
