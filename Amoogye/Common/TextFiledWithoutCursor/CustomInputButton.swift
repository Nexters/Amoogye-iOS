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

        checkBelowDecimalPoint()
    }

    func focusOn() {
        isFocusOn = true
        isPlaceholder = true

        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.amOrangeyRed.cgColor
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

    private func setAsPlaceholder() {
        recentText = self.title(for: .normal) ?? ""
        self.setTitleColor(UIColor.amLightBlueGrey, for: .normal)
        isDotClicked = false
    }

    private func setAsCommonText() {
        if isFocusOn {
            self.setTitleColor(UIColor.amOrangeyRed, for: .normal)
            return
        }

        if self.title(for: .normal) == "" {
            self.setTitle(recentText, for: .normal)
        }
        self.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
    }

    private func checkBelowDecimalPoint() {
        guard var text = self.title(for: .normal) else { return }

        guard text.count > 0 else {return}
        let end = text.index(before: text.endIndex)
        if text[end] == "." { // 소숫점 제거
            text = String(text[..<end])
        } else if isDotClicked && text[end] == "0" { // .0 제거
            text = String(Int(Double(text) ?? 0))
        }

        self.setTitle(text, for: .normal)
    }
}
