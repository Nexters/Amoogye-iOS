//
//  CustomInputTextBox.swift
//  Amoogye
//
//  Created by 임수현 on 18/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class CustomInputButton: UIButton {

    let label: UILabel = UILabel()

    var recentText: String = ""
    var isPlaceholder: Bool = true {
        didSet {
            switch isPlaceholder {
            case true:
                setAsPlaceholder()
            case false:
                setAsCommonText()
            }
        }
    }

    override func draw(_ rect: CGRect) {
        resizeView()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        focusOn()
    }

    // MARK: - Setup
    func setupLayout() {
        // radius: 6pt
        // font size: 20pt
        self.clipsToBounds = true
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1

        self.snp.makeConstraints { (view) in
            view.height.equalTo(36)
            view.width.equalTo(36)
        }
    }

    func setupSubview() {
        self.addSubview(label)

        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center

        label.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
        }
    }

    func resizeView() {
        label.sizeToFit()

        self.snp.remakeConstraints { (make) in
            make.height.equalTo(36)
            if label.bounds.width < 36 {
                make.width.equalTo(36)
            } else {
                make.width.equalTo(label.snp.width).offset(20)
            }
        }

        label.snp.remakeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
        }

        print("label width: \(label.bounds.width)")
        print("view width: \(self.frame.width)")

    }

    // MARK: - Focusing Mode
    func focusOn() {
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.amOrangeyRed.cgColor

        isPlaceholder = true
        self.setNeedsDisplay()
    }

    func focusOut() {
        self.backgroundColor = UIColor.amIceBlue
        self.layer.borderColor = UIColor.amIceBlue.cgColor

        isPlaceholder = false
        recentText = label.text ?? ""
        self.setNeedsDisplay()
    }

    // MARK: - Edit Text
    func setText(set: String) {
        if set == "" {
            isPlaceholder = true
            label.text = recentText
        } else {
            isPlaceholder = false
            label.text = set
        }

        label.sizeToFit()
        self.setNeedsDisplay()

        print("background: \(self.backgroundColor ?? UIColor.clear)")
        print("text: \(self.label.text ?? "")")
        print("width: \(label.bounds.width)")
    }

    func inputText(input: String) {
        if input == "" {
            return
        }

        guard let text = label.text else { return }
        isPlaceholder = false
        label.text = text + input
        label.sizeToFit()
        self.setNeedsDisplay()
    }

    func removeAllText() {
        isPlaceholder = true
        label.text = recentText
        label.sizeToFit()
        self.setNeedsDisplay()
    }

    // MARK: - Text Mode ( placeholder / common )
    func setAsPlaceholder() {
        label.text = recentText
        label.textColor = UIColor.amLightBlueGrey
    }

    func setAsCommonText() {
        label.textColor = UIColor.amDarkBlueGrey
    }
}
