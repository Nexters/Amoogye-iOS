//
//  TextField.swift
//  Amoogye
//
//  Created by 임수현 on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class CustomTextField_bak: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    var recentText = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        // cursor: NONE
        // radius: 6pt
        // font size: 20pt
        self.tintColor = UIColor.clear
        self.layer.cornerRadius = 6
        self.font = .systemFont(ofSize: 20)
        self.textAlignment = .center
        self.layer.borderWidth = 1

        self.focusOut()// touch (start editing)
        self.addTarget(self, action: #selector(self.touchEvent), for: UIControl.Event.editingDidBegin)
        self.addTarget(self, action: #selector(self.endTouchEvent), for: UIControl.Event.editingDidEnd)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    @objc func touchEvent(textfield: UITextField) {
        focusOn()
    }

    @objc func endTouchEvent(textfield: UITextField) {
        focusOut()
    }

    func focusOn() {
        // selected background: #white
        // selected border: #orangeyRed
        // selected font: #orangeyRed
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.amOrangeyRed.cgColor
        self.textColor = UIColor.amOrangeyRed

        if let currentText = self.text {
            if currentText != "" {
                self.recentText = currentText
            }
            self.placeholder = recentText
            self.text = ""
        }
    }

    func focusOut() {
        // unselected background: #iceBlue
        // unselected border: NONE
        // unselected font: #darkBlueGrey
        self.backgroundColor = UIColor.amIceBlue
        self.layer.borderColor = UIColor.amIceBlue.cgColor
        self.textColor = UIColor.amDarkBlueGrey
        if self.text == "" {
            self.text = recentText
        } else {
            recentText = self.text ?? ""
        }
    }

    func setDefaultText(text: String) {
        self.text = text
    }

}
