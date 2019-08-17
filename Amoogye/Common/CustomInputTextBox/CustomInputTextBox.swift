//
//  CustomInputTextBox.swift
//  Amoogye
//
//  Created by 임수현 on 18/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class CustomInputTextBox: UIView {

    let label: UILabel = UILabel()
    let button: UIButton = UIButton()

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

    override func awakeFromNib() {
        self.setup()
        self.focusOut()
    }

    override func draw(_ rect: CGRect) {
        resizeView()
    }

    // MARK: - Setup
    func setup() {
        // radius: 6pt
        // font size: 20pt
        self.clipsToBounds = true
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1

        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center

        self.addSubview(label)
        self.addSubview(button)

        self.setNeedsDisplay()  //

        button.addTarget(self, action: #selector(self.touchEvent), for: UIControl.Event.touchDown)
    }

    func resizeView() {
        // label 크기 구하기
        label.sizeToFit()
        var width = Float(label.intrinsicContentSize.width) + 16
        if width < 36 { width = 36 }

        // superview (최소너비: 36)
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: CGFloat(width), height: 36)
        // label (superview의 중앙에 오도록)
        label.frame = CGRect(x: (self.bounds.size.width - label.bounds.size.width)/2, y: (self.bounds.size.height - label.bounds.size.height)/2, width: label.bounds.size.width, height: label.bounds.size.height)
        // button (superview의 크기와 동일하도록)
        button.frame = self.bounds
    }

    // MARK: Event
    @objc func touchEvent(button: UIButton) {
        focusOn()
    }

    // MARK: - Focusing Mode
    func focusOn() {
        // background = white
        // border color = amOrangeyRed
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.amOrangeyRed.cgColor

        isPlaceholder = true
        self.setNeedsDisplay()
    }

    func focusOut() {
        // background = amIceBlue
        // border color = amIceBlue
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
            return
        }

        isPlaceholder = false
        label.text = set
        label.sizeToFit()
        self.setNeedsDisplay()
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
