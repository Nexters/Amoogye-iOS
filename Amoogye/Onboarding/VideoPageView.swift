//
//  VideoPageView.swift
//  Amoogye
//
//  Created by JunHui Kim on 07/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit
import AVKit

class VideoPageView: PageView {
    var playerView: UIView!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var replayButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup(contentView: UIView, filename: String, title: String, description: String) {
        super.setupPageText(title: title, description: description)

        setupPlayerView(filename)
        setupReplayButton()

        setupConstraint(superView: contentView)
    }

    @objc func clickReplayButton(sender: UIButton) {
        stop()
        play()
    }
}

extension VideoPageView: ContentsDelegate {
    func play() {
        player.play()
    }

    func stop() {
        player.pause()
        player.seek(to: CMTime.zero)
    }
}

// MARK: - setup
extension VideoPageView {
    private func setupPlayerView(_ filename: String) {
        playerView = UIView()

        guard let path = Bundle.main.path(forResource: filename, ofType: "mp4") else {
            print("Error: Can not find video file - [\(filename).mp4]")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        playerLayer = AVPlayerLayer(player: player)
    }

    private func setupReplayButton() {
        replayButton = UIButton()
        replayButton.setImage(UIImage(named: "replay"), for: .normal)

        replayButton.addTarget(self, action: #selector(clickReplayButton(sender:)), for: .touchUpInside)
    }
}

// MARK: - constraint
extension VideoPageView {
    private func setupConstraint(superView: UIView) {
        superView.addSubview(playerView)
        superView.addSubview(replayButton)
        superView.addSubview(pageTitle)
        superView.addSubview(pageDescription)

        let contentWidth = superView.frame.width
        let contentHeight = 1008 * (contentWidth / 750)

        playerView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(superView)
            make.height.equalTo(contentHeight)
        }
        replayButton.snp.makeConstraints { (make) -> Void in
            make.bottom.right.equalTo(playerView).offset(-16)
        }
        pageTitle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(playerView.snp.bottom).offset(28)
            make.centerX.equalTo(superView.snp.centerX)
        }
        pageDescription.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(pageTitle.snp.bottom).offset(12)
            make.centerX.equalTo(superView.snp.centerX)
        }

        playerView.layer.addSublayer(playerLayer)
        playerLayer.frame = CGRect(x: 0, y: 0, width: contentWidth, height: contentHeight)
    }
}
