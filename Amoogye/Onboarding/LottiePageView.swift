//
//  LottiePageView.swift
//  Amoogye
//
//  Created by JunHui Kim on 07/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class LottiePageView: PageView {
    var contentBackground: UIView!
    var lottieView: AnimationView!

    var endFrame: AnimationFrameTime?
    var repeatFrame: AnimationFrameTime?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup(contentView: UIView, filename: String, endFrame: CGFloat, repeatFrame: CGFloat, title: String, description: String) {
        super.setupPageText(title: title, description: description)

        setupContentBackground()
        setupLottieView(filename, endFrame: endFrame, repeatFrame: repeatFrame)

        setupConstraint(superView: contentView)
    }
}

extension LottiePageView: ContentsDelegate {
    func play() {
        lottieView.play(fromFrame: 0, toFrame: endFrame ?? 0, loopMode: .playOnce, completion: { (_) in
            self.lottieView.play(fromFrame: self.repeatFrame ?? 0, toFrame: self.endFrame ?? 0, loopMode: .loop)
        })
    }

    func stop() {
        lottieView.stop()
    }
}

// MARK: - setup
extension LottiePageView {
    private func setupContentBackground() {
        contentBackground = UIView()

        contentBackground.backgroundColor = UIColor(displayP3Red: 241.0/255.0, green: 246/255.0, blue: 255/255.0, alpha: 1.0)
    }

    private func setupLottieView(_ filename: String, endFrame: AnimationFrameTime, repeatFrame: AnimationFrameTime) {
        lottieView = AnimationView(name: filename)

        lottieView.contentMode = .scaleAspectFit

        self.endFrame = endFrame
        self.repeatFrame = repeatFrame
    }
}

// MARK: - constraint
extension LottiePageView {
    private func setupConstraint(superView: UIView) {
        superView.addSubview(contentBackground)
        superView.addSubview(lottieView)
        superView.addSubview(pageTitle)
        superView.addSubview(pageDescription)

        let contentWidth = superView.frame.width
        let contentHeight = 750 * (contentWidth / 750)

        contentBackground.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(superView)
            make.height.equalTo(contentHeight)
        }
        lottieView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(contentBackground).offset(16)
            make.right.equalTo(contentBackground).offset(-16)
            make.bottom.equalTo(contentBackground)
            make.height.equalTo(292)
        }
        pageTitle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(lottieView.snp.bottom).offset(28)
            make.centerX.equalTo(superView.snp.centerX)
        }
        pageDescription.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(pageTitle.snp.bottom).offset(12)
            make.centerX.equalTo(superView.snp.centerX)
        }
    }
}
