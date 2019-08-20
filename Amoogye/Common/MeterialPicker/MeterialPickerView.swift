//
//  MeterialPickerView.swift
//  Amoogye
//
//  Created by 임수현 on 16/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeterialPickerView: UIView {

    let meterialList = ["굴소스", "간장", "소금", "밀가루", "물", "베이킹파우더", "고추장"]
    var delegate: MeterialPickerDelegate?

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var defaultOrderButton: UIButton!
    @IBOutlet weak var recentOrderButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }

    func initializeSubviews() {
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else {
            return
        }

        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        picker.delegate = self
        picker.dataSource = self
    }

    // 기본 순
    @IBAction func defaultButtonClick(_ sender: Any) {
        defaultOrderButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        recentOrderButton.setTitleColor(UIColor.amLightBlueGrey, for: .normal)
    }

    // 최근 사용 순
    @IBAction func recentButtonClick(_ sender: Any) {
        defaultOrderButton.setTitleColor(UIColor.amLightBlueGrey, for: .normal)
        recentOrderButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
    }

    // 재료 검색
    @IBAction func searchButtonClick(_ sender: Any) {
        print("show search view")
        delegate?.openMeterialSearchView()
    }
}

extension MeterialPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return meterialList.count
    }
}

extension MeterialPickerView: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.selectMeterial(name: meterialList[row])
        pickerView.reloadAllComponents()
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return meterialList[row]
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        picker.subviews[1].backgroundColor = UIColor.amIceBlue
        picker.subviews[2].backgroundColor = UIColor.amIceBlue

        let selectedRow = pickerView.selectedRow(inComponent: component)
        var color = UIColor.amDarkBlueGrey

        if row == selectedRow {
            color = UIColor.amOrangeyRed
        }

        return NSAttributedString(string: meterialList[row], attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
