//
//  NumericKeyboardView.swift
//  Amoogye
//
//  Created by JunHui Kim on 14/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class NumericKeyboardView: UIView {
    var delegate: NumericKeyboardDelegate?
    var isDotClicked = false

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
    }

    @IBAction func touchNumberButton(_ sender: UIButton) {
        self.delegate?.inputNumber(number: sender.titleLabel!.text!)
    }

    @IBAction func touchDotButton(_ sender: UIButton) {
        if !isDotClicked {
            self.delegate?.inputDot()
            isDotClicked = true
        }
    }

    @IBAction func touchDeleteButton(_ sender: UIButton) {
        self.delegate?.deleteValue()
    }
}
