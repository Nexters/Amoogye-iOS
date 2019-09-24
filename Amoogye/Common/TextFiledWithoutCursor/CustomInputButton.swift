//
//  CustomInputButton.swift
//  Amoogye
//
//  Created by 임수현 on 23/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class CustomInputButton: UIButton {

    var recentText: String = ""
    var isDotClicked: Bool = false
    var isFocusOn: Bool = false
    var isPlaceholder: Bool = false {
        didSet {
            if isPlaceholder { setAsPlaceholder() } else { setAsCommonText() }
        }
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setRound()
        setFontStyle()
        setupLayout()
        focusOut()
    }

    private func setupLayout() {
        guard let label = self.titleLabel else { return}

        label.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }

        self.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo(36)
            make.height.equalTo(36)
        }
    }

    func focusOut() {
        isFocusOn = false
        isPlaceholder = false

        self.layer.borderColor = UIColor.amIceBlue.cgColor
        self.backgroundColor = UIColor.amIceBlue
    }

    func focusOn() {
        isFocusOn = true
        isPlaceholder = true

        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.amOrangeyRed.cgColor
    }

    func setAsPlaceholder() {
        recentText = self.title(for: .normal) ?? ""
        self.setTitleColor(UIColor.amLightBlueGrey, for: .normal)
        isDotClicked = false
    }

    func setAsCommonText() {
        if isFocusOn {
            self.setTitleColor(UIColor.amOrangeyRed, for: .normal)
            return
        }

        if self.title(for: .normal) == "" {
            self.setTitle(recentText, for: .normal)
        }
        self.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
    }

    func getLastInputValue() -> String {
        guard let text = self.title(for: .normal) else { return "" }

        if text.count > 0 {
            let lastIndex = text.index(before: text.endIndex)
            return String(text[lastIndex])
        }

        return ""
    }
}

extension CustomInputButton {
    private func setRound() {
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
    }

    private func setFontStyle() {
        self.titleLabel?.font = .systemFont(ofSize: 20)
        self.titleLabel?.textAlignment = .center
    }
}
