//
//  MeterialPickerView.swift
//  Amoogye
//
//  Created by 임수현 on 03/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeterialPickerView: UIView {

    weak var myView: MyView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitialization()
    }

    func commonInitialization() {
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last
            else { return }
        let nib = UINib(nibName: xibName, bundle: Bundle.main)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        myView = view as? MyView
    }
}

class MyView: UIView {
    let meterialList = ["굴소스", "간장", "소금", "밀가루", "물", "베이킹파우더", "고추장"]

    @IBOutlet weak var defaultOrderButton: UIButton!
    @IBOutlet weak var recentOrderButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!

    weak var delegate: MeterialPickerDelegate?

    override func draw(_ rect: CGRect) {
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    @IBAction func defaultButtonClick(_ sender: Any) {
        defaultOrderButton.setTitleColor(UIColor.black, for: .normal)
        recentOrderButton.setTitleColor(UIColor.lightGray, for: .normal)
    }

    @IBAction func recentButtonClick(_ sender: Any) {
        defaultOrderButton.setTitleColor(UIColor.lightGray, for: .normal)
        recentOrderButton.setTitleColor(UIColor.black, for: .normal)
    }
}

extension MyView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return meterialList.count
    }
}

extension MyView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return meterialList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.meterialSelected(row: row, title: meterialList[row])
    }
}

protocol MeterialPickerDelegate: class {
    func meterialSelected(row: Int, title: String)
}
