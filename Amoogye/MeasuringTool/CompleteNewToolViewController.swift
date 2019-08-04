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
        // TODO: Realm save
        print("""
            New Measuring Tool
            Name: \(newMeasuringTool!.name)
            Unit: \(newMeasuringTool!.unit)
            Quantity: \(newMeasuringTool!.quantity)
            Subname: \(newMeasuringTool!.subname)
            """)
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
