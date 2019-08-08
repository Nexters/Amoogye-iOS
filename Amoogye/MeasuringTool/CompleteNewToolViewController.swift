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
    var measuringToolManager = RMMeasuringToolManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func closeButtonClick(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func okButtonClick(_ sender: Any) {
        measuringToolManager.addMeasuringTool(object: newMeasuringTool!)

        navigationController?.dismiss(animated: true, completion: nil)
    }
}
