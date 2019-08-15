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
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newToolNameLabel.delegate = self
        setupNextButton()
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

extension SetNameForNewToolViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        decideNextButtonIsActive(isTextEmpty: text.isEmpty)

        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        decideNextButtonIsActive(isTextEmpty: true)

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - 다음 버튼 세팅 함수
extension SetNameForNewToolViewController {
    private func setupNextButton() {
        nextButton.layer.cornerRadius = 6

        if self.newToolNameLabel.text!.isEmpty {
            self.nextButton.isUserInteractionEnabled = false
            nextButton.backgroundColor = UIColor(displayP3Red: 224/255, green: 228/255, blue: 230/255, alpha: 1)
        }
    }

    private func decideNextButtonIsActive(isTextEmpty: Bool) {
        if !isTextEmpty {
            nextButton.isUserInteractionEnabled = true
            nextButton.backgroundColor = UIColor.amOrangeyRed
        } else {
            nextButton.isUserInteractionEnabled = false
            nextButton.backgroundColor = UIColor(displayP3Red: 224/255, green: 228/255, blue: 230/255, alpha: 1)
        }
    }
}
