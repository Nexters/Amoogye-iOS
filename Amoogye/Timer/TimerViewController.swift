//
//  TimerViewController.swift
//  Amoogye
//
//  Created by 임수현 on 25/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    var numericKeyboardButtonTitles = [String]()

    var timerModel = TimerModel()
    let colorGreen = UIColor(displayP3Red: 109/255, green: 212/255, blue: 0, alpha: 1)

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var hourTextfield: CustomTextField!
    @IBOutlet weak var minTextfield: CustomTextField!
    @IBOutlet weak var secTextfield: CustomTextField!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!

    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerLabel: UILabel!

    @IBOutlet weak var numericKeyboardView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNumericKeyboard()
        setUpTextfield()
        setButtonStyle(startButton, pauseButton, cancelButton)
    }

    func setUpTextfield() {
        let textfieldManager = CustomTextfieldManager(hourTextfield, minTextfield, secTextfield)
        hourTextfield.manager = textfieldManager
        minTextfield.manager = textfieldManager
        secTextfield.manager = textfieldManager
    }

    func setButtonStyle(_ buttons: UIButton...) {
        for button in buttons {
            button.layer.cornerRadius = 6
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hourTextfield.focusOut()
        minTextfield.focusOut()
        secTextfield.focusOut()
    }

    @IBAction func clickStart(_ sender: Any) {
        if timerModel.isWorkingTimer {
            checkFinishTimer()
            numericKeyboardView.isHidden = false
        } else if getSecond() > 0 {
            startTimer()
            showPauseButton()
            setTimerTextfieldsEnable(booltype: false)
            numericKeyboardView.isHidden = true
        }
    }

    @IBAction func clickPause(_ sender: Any) {
        if timerModel.isWorkingTimer {
            pauseTimer()
            showRestartButton()
        } else {
            startTimer()
            showPauseButton()
        }
    }

    @IBAction func clickCancel(_ sender: Any) {
        // 취소 시
        cancelTimer()
        showStartButton()
        setTimerTextfieldsEnable(booltype: true)
        numericKeyboardView.isHidden = false
    }
}

extension TimerViewController {

    // MARK: - Setup 관련 함수
//    func setupMaxTimeLimit() {
//
//    }

    func setTimerTextfieldsEnable(booltype: Bool) {
        hourTextfield.isEnabled = booltype
        minTextfield.isEnabled = booltype
        secTextfield.isEnabled = booltype
        hourTextfield.focusOut()
        minTextfield.focusOut()
        secTextfield.focusOut()
    }

    func setTimerLabelText(hour: Int, min: Int, sec: Int) {
        timerLabel.text = String(format: "%02d : %02d : %02d", hour, min, sec)
    }

    func showStartButton() {
        startButton.isHidden = false
        cancelButton.isHidden = true
        pauseButton.isHidden = true
    }

    func showPauseButton() {
        startButton.isHidden = true
        cancelButton.isHidden = false
        pauseButton.isHidden = false
        pauseButton.setTitle("일시정지", for: .normal)
    }

    func showRestartButton() {
        startButton.isHidden = true
        cancelButton.isHidden = false
        pauseButton.isHidden = false
        pauseButton.setTitle("다시 시작", for: .normal)
    }

    func showSettingView() {
        settingView.isHidden = false
        timerView.isHidden = true
    }

    func showTimerView() {
        settingView.isHidden = true
        timerView.isHidden = false
    }

    // MARK: - 변환 관련 함수
    func getSecond() -> Int {
        let hour: Int = textfieldToInt(tf: hourTextfield)
        let min: Int = textfieldToInt(tf: minTextfield)
        let sec: Int = textfieldToInt(tf: secTextfield)
        return hour * 3600 + min * 60 + sec
    }

    func textfieldToInt(tf: UITextField) -> Int {
        guard let text = tf.text else {
            return 0
        }
        return Int(text) ?? 0
    }

    // MARK: - 타이머 작동 관련 함수
    func startTimer() {
        timerModel.isWorkingTimer = true

        timerModel.time = getSecond()
        timerModel.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.decreaseTime), userInfo: nil, repeats: true)

        showPauseButton()
        showTimerView()
        setTimerLabelText(hour: timerModel.time/3600, min: (timerModel.time%3600)/60, sec: (timerModel.time%3600)%60)
    }

    func pauseTimer() {
        timerModel.isWorkingTimer = false
        timerModel.timer.invalidate()

        showStartButton()
    }

    func cancelTimer() { // 취소 시
        timerModel.isWorkingTimer = false
        timerModel.timer.invalidate()
        showStartButton()
        showSettingView()
    }

    func finishTimer() { // 시간 종료 시
        timerModel.timer.invalidate()
        showStartButton()
        showSettingView()
        alertFinishTimer()
    }

    // 1초에 한번씩 실행
    @objc func decreaseTime() {
        if timerModel.time > 1 {
            timerModel.time -= 1
            setTimerLabelText(hour: timerModel.time/3600, min: (timerModel.time%3600)/60, sec: (timerModel.time%3600)%60)
        } else {
            // 시간 종료 시
            finishTimer()
        }
    }

    func alertFinishTimer() {
        secLabel.text = "초가"
        alertLabel.text = "끝났습니다!"
        startButton.setTitle("종료", for: .normal)
        setTimerTextfieldsEnable(booltype: false)
    }

    func checkFinishTimer() {
        cancelTimer()
        secLabel.text = "초 뒤에"
        alertLabel.text = "알려드릴게요!"
        startButton.setTitle("시작하기", for: .normal)
        setTimerTextfieldsEnable(booltype: true)
    }
}

// MARK: - numeric keyboard
extension TimerViewController {

    private func hideKeyboards() {
        numericKeyboardView.isHidden = true
    }

    private func setupNumericKeyboard() {
        numericKeyboardButtonTitles = makeNumericKeyboardButtonTitles()

        let nibCell = UINib(nibName: "NumericKeyboardCollectionViewCell", bundle: nil)
        self.numericKeyboardView.register(nibCell, forCellWithReuseIdentifier: "NumericKeyboardCollectionViewCell")

        self.numericKeyboardView.delegate = self
        self.numericKeyboardView.dataSource = self
    }
    private func makeNumericKeyboardButtonTitles() -> [String] {
        var contents: [String] = []

        for i in 1..<10 {
            contents.append(String(i))
        }
        contents.append("0")
        contents.append(".")
        contents.append("del")

        return contents
    }

    private func cellWithNumericKeyboardButtonTitle(_ cell: NumericKeyboardCollectionViewCell, with buttonTitle: String) -> NumericKeyboardCollectionViewCell {
        if buttonTitle == "del" {
            cell.keyboardButton.setImage(UIImage(named: "keyboardBackspace"), for: .normal)
            cell.keyboardButton.setTitle("", for: .normal)
            return cell
        }

        cell.keyboardButton.setTitle(buttonTitle, for: .normal)
        return cell
    }
}

extension TimerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numericKeyboardButtonTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumericKeyboardCollectionViewCell", for: indexPath) as! NumericKeyboardCollectionViewCell
        let buttonTitle = numericKeyboardButtonTitles[indexPath.item]

        return cellWithNumericKeyboardButtonTitle(cell, with: buttonTitle)
    }
}

extension TimerViewController: UICollectionViewDelegate {

}

extension TimerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 3 - 1
        let cellHeight = collectionView.frame.height / 4 - 1

        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
