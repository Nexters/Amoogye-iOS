//
//  CompleteNewToolViewController.swift
//  Amoogye
//
//  Created by 임수현 on 30/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import Lottie

class CompleteNewToolViewController: UIViewController {
    var newMeasuringTool: MeasuringTool?
    var measuringToolManager: RealmMeasuringToolManager?

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var newToolNameAndValue: UILabel!
    @IBOutlet weak var confirmButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.newToolNameAndValue.text = newMeasuringTool!.name + "(" + newMeasuringTool!.subname + ")"
        setupConfirmButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupAndPlayAnimation()
    }

    @IBAction func clickBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func clickConfirmButton(_ sender: UIButton) {
        measuringToolManager?.addMeasuringTool(newMeasuringTool!)

        navigationController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - 다음 버튼 세팅 함수
extension CompleteNewToolViewController {
    private func setupConfirmButton() {
        confirmButton.layer.cornerRadius = 6
    }
}

// MARK: - Animation
extension CompleteNewToolViewController {
    func setupAndPlayAnimation() {
        let lottieView = AnimationView(name: "addtool03_iOS")

        self.animationView.addSubview(lottieView)

        lottieView.snp.makeConstraints {(make) -> Void in
            make.top.bottom.left.right.equalTo(self.animationView)
        }

        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop

        lottieView.play()
    }
}
