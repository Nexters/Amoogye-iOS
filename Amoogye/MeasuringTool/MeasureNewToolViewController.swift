//
//  MeasureNewToolViewController.swift
//  Amoogye
//
//  Created by 임수현 on 30/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import Lottie

class MeasureNewToolViewController: UIViewController {
    var measuringToolManager: RealmMeasuringToolManager?

    // MARK: - 이전 segue에서 받은 데이터
    var toolNameInput: String?

    // MARK: - 계량도구 추가에 이용할 데이터
    var toolList: [MeasuringTool]?
    var selectedCriteriaTool: MeasuringTool?
    var measuringCount: String?

    // MARK: - UI Outlet
    @IBOutlet weak var animationView: UIView!

    @IBOutlet weak var newToolNameLabel: UILabel!

    @IBOutlet weak var toolSelectionField: UITextField!
    @IBOutlet weak var measuringCountIntLabel: UITextField!
    @IBOutlet weak var measuringCountFloatLabel: UITextField!

    @IBOutlet weak var nextButton: UIButton!

    var measuringPicker: PickerView!
    var measuringPickerToolBar: UIToolbar!

    // MARK: - override 함수
    override func viewDidLoad() {
        super.viewDidLoad()

        toolSelectionField.delegate = self
        measuringCountIntLabel.delegate = self
        measuringCountFloatLabel.delegate = self

        setupNewToolNameLabel()
        loadToolList()
        setupInitMeasuring()
        setupNextButton()
        setupPicker()
        setupFieldWithPicker()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToComplete" {

            // 다음 컨트롤러에 데이터 전달
            if let destination = segue.destination as? CompleteNewToolViewController {
                destination.newMeasuringTool = measuringToolManager?.newMeasuringTool(name: newToolNameLabel.text!, criteriaTool: selectedCriteriaTool!, count: measuringCount!)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        setupAndPlayAnimation()
    }

    // MARK: - 버튼 동작 함수
    @IBAction func clickNextButton(_ sender: UIButton) {
        self.selectedCriteriaTool = measuringToolManager?.getMeasuringTool(toolSelectionField.text!)
        self.measuringCount = measuringCountIntLabel.text! + "." + measuringCountFloatLabel.text!

        self.performSegue(withIdentifier: "segueToComplete", sender: self)
    }

    @IBAction func backButtonClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func closeButtonClick(_ sender: Any) {
        let alertMessage = """
계량도구 추가를 모두
취소 하시겠습니까?
"""
        let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "예", style: .default, handler: { (_) -> Void in
            self.navigationController?.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel, handler: { (_) -> Void in
            return
        })

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }

    @objc private func clickConfirmButton(_ button: UIBarButtonItem?) {
        self.measuringPicker.textFieldBeingEdited?.text = measuringPicker.selectedValue
        self.measuringPicker.textFieldBeingEdited?.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - 초기값 세팅 함수
extension MeasureNewToolViewController {
    // UI
    private func setupNewToolNameLabel() {
        self.newToolNameLabel.text = self.toolNameInput
    }

    private func setupNextButton() {
        nextButton.layer.cornerRadius = 6

        validateNextButton(text: self.toolSelectionField.text!)
        validateNextButton(text: self.measuringCountIntLabel.text!)
        validateNextButton(text: self.measuringCountFloatLabel.text!)
    }

    private func setupPicker() {
        // Picker View
        self.measuringPicker = PickerView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 254))
        self.measuringPicker.backgroundColor = UIColor.amIceBlue

        // Picker Tool Bar
        self.measuringPickerToolBar = UIToolbar()
        measuringPickerToolBar?.barStyle = .default
        measuringPickerToolBar?.isTranslucent = false
        measuringPickerToolBar?.frame.size.height = 42

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let confirmButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(clickConfirmButton(_:)))
        confirmButton.tintColor = UIColor.amDarkBlueGrey
        confirmButton.title = "완료"

        measuringPickerToolBar?.items = [flexSpace, confirmButton]
    }

    private func setupFieldWithPicker() {
        self.toolSelectionField.inputView = self.measuringPicker
        self.toolSelectionField.inputAccessoryView = self.measuringPickerToolBar

        self.measuringCountIntLabel.inputView = self.measuringPicker
        self.measuringCountIntLabel.inputAccessoryView = self.measuringPickerToolBar

        self.measuringCountFloatLabel.inputView = self.measuringPicker
        self.measuringCountFloatLabel.inputAccessoryView = self.measuringPickerToolBar
    }

    // Data
    private func setupInitMeasuring() {
        self.toolSelectionField.text = toolList?.first?.name
        self.measuringCountIntLabel.text = "1"
        self.measuringCountFloatLabel.text = "0"
    }

    private func loadToolList() {
        self.toolList = measuringToolManager?.getUsingOnLivingMeasuringToolList()
    }
}

// MARK: - TextField 관련 함수
extension MeasureNewToolViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        validateNextButton(text: text)

        return true
    }

    private func validateNextButton(text: String) {
        if !validateEmptyText(text) {
            decideNextButtonIsActive(isActive: false)
        } else {
            decideNextButtonIsActive(isActive: true)
        }
    }

    private func validateEmptyText(_ text: String) -> Bool {
        if text.isEmpty {
            return false
        }
        return true
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

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.measuringPicker.setEditingTextField(textField)

        switch textField {
        case toolSelectionField:
            self.measuringPicker.setItemList(self.toolList!.map { $0.name })
        case measuringCountIntLabel:
            self.measuringPicker.setItemList([Int](1...50).map { String($0) })
        case measuringCountFloatLabel:
            self.measuringPicker.setItemList([Int](0...9).map { String($0) })
        default:
            self.measuringPicker.setItemList([])
        }

        self.measuringPicker.setPickerItem(withSelectedItem: textField.text!)
    }
}

// MARK: - Animation
extension MeasureNewToolViewController {
    func setupAndPlayAnimation() {
        let lottieView = AnimationView(name: "addtool02_iOS")

        self.animationView.addSubview(lottieView)

        lottieView.snp.makeConstraints {(make) -> Void in
            make.top.bottom.left.right.equalTo(self.animationView)
        }

        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop

        lottieView.play()
    }
}
