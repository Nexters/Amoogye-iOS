//
//  AddToolSetNameViewController.swift
//  Amoogye
//
//  Created by 임수현 on 29/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class SetNameForNewToolViewController: UIViewController {

    @IBOutlet weak var newToolNameLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSetTool" {
            guard let toolNameInput = newToolNameLabel.text else {
                print("No tool name label!")
                return
            }

            // 다음 컨트롤러에 데이터 전달
            let destination = segue.destination as! SetToolForNewToolViewController
            destination.toolNameInput = toolNameInput
        }
    }

    @IBAction func closeButtonClick(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
