//
//  CompleteNewToolViewController.swift
//  Amoogye
//
//  Created by 임수현 on 30/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class CompleteNewToolViewController: UIViewController {
    var newMeasuringTool: MeasuringTool?
    var measuringToolManager: RealmMeasuringToolManager?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newToolNameAndValue: UILabel!
    @IBOutlet weak var confirmButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.newToolNameAndValue.text = newMeasuringTool!.name + "(" + newMeasuringTool!.subname + ")"
        setupConfirmButton()
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
