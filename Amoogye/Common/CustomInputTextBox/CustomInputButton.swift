//
//  CustomInputTextBox.swift
//  Amoogye
//
//  Created by 임수현 on 18/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class CustomInputButton: UIButton {

    var recentText: String = ""
    var focus: Bool = false

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        setup()
    }

    init(title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        self.setTitle(title)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        focusOn()
//        setTitle("안녕")
    }

    func setup() {
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.titleLabel?.font = .systemFont(ofSize: 20)
        focusOut()
    }

    func resize() {
        guard let label = self.titleLabel else {
            return
        }

        label.sizeToFit()
        var width: CGFloat = 36
        if label.bounds.width > 16 {
            width = label.bounds.width + CGFloat(20)
        }
        self.bounds.size.width = width
        self.snp.remakeConstraints { (make) in
            make.centerX.equalTo(label)
            make.left.equalTo(label).offset(-10)
            make.right.equalTo(label).offset(10)
            make.width.equalTo(width)
        }
    }

    func focusOn() {
        focus = true
        self.setTitleColor(UIColor.amLightBlueGrey, for: .normal)
        self.layer.borderColor = UIColor.amOrangeyRed.cgColor
        self.backgroundColor = UIColor.white
        setPlaceholder()
    }

    func focusOut() {
        recentText = self.title(for: .normal) ?? ""
        focus = false
        self.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        self.layer.borderColor = UIColor.amIceBlue.cgColor
        self.backgroundColor = UIColor.amIceBlue
        if self.title(for: .normal) == "" {
            self.setTitle(recentText)
        } else {
            recentText = title(for: .normal) ?? ""
        }
    }

    func setPlaceholder() {
        if let currentText = self.title(for: .normal) {
            if currentText != "" {
                self.recentText = currentText
            }
            self.setTitle(recentText)
        }
        setTitleColor(UIColor.amLightBlueGrey, for: .normal)
    }

    func setTitle(_ title: String) {
        self.setTitle(title, for: .normal)
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        if focus {
            self.setTitleColor(UIColor.amOrangeyRed, for: .normal)
        } else {
            self.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        }
        resize()
    }

    func removeAllText() {
        setPlaceholder()
    }
}
