//
//  MeterialPickerView.swift
//  Amoogye
//
//  Created by 임수현 on 03/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeterialPickerView: UIView {

    weak var myView: PickerView?

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
        myView = view as? PickerView
    }
}

protocol MeterialPickerDelegate: class {
    func meterialSelected(row: Int, title: String)
    func meterialSearchViewOpen()
    func meterialSearchViewClose()
}
