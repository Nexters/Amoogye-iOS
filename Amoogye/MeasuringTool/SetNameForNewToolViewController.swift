//
//  AddToolSetNameViewController.swift
//  Amoogye
//
//  Created by 임수현 on 29/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit

class SetNameForNewToolViewController: UIViewController {

    var measuringToolManager: RealmMeasuringToolManager?
    var keyboardHeight = CGFloat(0)

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var guideTextView: UIView!
    @IBOutlet weak var inputTextView: UIView!

    @IBOutlet weak var newToolNameLabel: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var alertTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newToolNameLabel.delegate = self
        setupNextButton()
        hideAlertMessage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func keyboardWillAppear(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
            print(Int(self.keyboardHeight))
        }
        setupInputConstraints()
    }

    @objc func keyboardWillDisappear() {
        setupNormalConstraints()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMeasure" {
            guard let toolNameInput = newToolNameLabel.text else {
                print("No tool name label!")
                return
            }

            // 다음 컨트롤러에 데이터 전달
            if let destination = segue.destination as? MeasureNewToolViewController {
                destination.toolNameInput = toolNameInput
            }
        }
    }

    @IBAction func clickNextButton(_ sender: UIButton) {
        if (measuringToolManager?.checkDuplicatedToolName(name: newToolNameLabel.text!))! {
            alertNameIsDuplicated()
        } else {
            self.performSegue(withIdentifier: "segueToMeasure", sender: self)
        }
    }

    @IBAction func closeButtonClick(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TextField 관련 함수
extension SetNameForNewToolViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        hideAlertMessage()
        validateText(text)

        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        hideAlertMessage()
        decideNextButtonIsActive(isActive: false)

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

        validateText(self.newToolNameLabel.text!)
    }

    private func decideNextButtonIsActive(isActive: Bool) {
        if isActive {
            nextButton.isUserInteractionEnabled = true
            nextButton.backgroundColor = UIColor.amOrangeyRed
        } else {
            nextButton.isUserInteractionEnabled = false
            nextButton.backgroundColor = UIColor(displayP3Red: 224/255, green: 228/255, blue: 230/255, alpha: 1)
        }
    }
}

// MARK: - 경고 메시지 함수
extension SetNameForNewToolViewController {
    private func alertNameIsTooLong() {
        self.alertTextLabel.text = "이름은 10자까지 입력할 수 있습니다."
        self.alertTextLabel.isHidden = false
    }

    private func alertNameIsDuplicated() {
        self.alertTextLabel.text = "같은 이름의 계량도구가 있습니다."
        self.alertTextLabel.isHidden = false
    }

    private func hideAlertMessage() {
        self.alertTextLabel.isHidden = true
    }
}

// MARK: - 실시간 텍스트 검사 함수
extension SetNameForNewToolViewController {
    private func validateText(_ text: String) {
        if !validateEmptyText(text) {
            decideNextButtonIsActive(isActive: false)
            return
        }

        if !validateLongText(text) {
            decideNextButtonIsActive(isActive: false)
            alertNameIsTooLong()
            return
        }

        decideNextButtonIsActive(isActive: true)
    }

    private func validateEmptyText(_ text: String) -> Bool {
        if text.isEmpty {
            return false
        }
        return true
    }

    private func validateLongText(_ text: String) -> Bool {
        if text.count > 10 {
            return false
        }
        return true
    }
}

extension SetNameForNewToolViewController {
    func setupInputConstraints() {
        self.imageView.isHidden = true

        self.nextButton.snp.remakeConstraints {(make) -> Void in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-(Int(keyboardHeight) + 16))
        }
        self.inputTextView.snp.remakeConstraints {(make) -> Void in
            make.bottom.equalTo(nextButton.snp.top).offset(-40)
        }
        self.guideTextView.snp.remakeConstraints {(make) -> Void in
            make.bottom.equalTo(inputTextView.snp.top).offset(0)
        }
    }

    func setupNormalConstraints() {
        self.imageView.isHidden = false

        self.guideTextView.snp.remakeConstraints {(make) -> Void in
            make.top.equalTo(imageView.snp.bottom).offset(28)
        }

        self.inputTextView.snp.remakeConstraints {(make) -> Void in
            make.top.equalTo(guideTextView.snp.bottom).offset(0)
        }

        self.nextButton.snp.remakeConstraints {(make) -> Void in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-28)
        }
    }
}
