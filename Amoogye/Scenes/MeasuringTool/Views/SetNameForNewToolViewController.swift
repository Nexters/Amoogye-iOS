//
//  AddToolSetNameViewController.swift
//  Amoogye
//
//  Created by 임수현 on 29/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class SetNameForNewToolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeButtonClick(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
