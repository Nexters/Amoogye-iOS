//
//  ViewController.swift
//  Amoogye
//
//  Created by 임수현 on 13/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    var numericKeyboardButtonTitles = [String]()

    @IBOutlet weak var resPortionTextfield: UITextField!
    @IBOutlet weak var desPortionTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var meterialButton: UIButton!

    @IBOutlet weak var numericKeyboardView: UICollectionView!
    @IBOutlet weak var meterialPickerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboards()
    }

    private func hideKeyboards() {
        numericKeyboardView.isHidden = true
        meterialPickerView.isHidden = true
    }

    private func setupNumericKeyboard() {
        numericKeyboardButtonTitles = makeNumericKeyboardButtonTitles()

        let nibCell = UINib(nibName: "NumericKeyboardCollectionViewCell", bundle: nil)
        self.numericKeyboardView.register(nibCell, forCellWithReuseIdentifier: "NumericKeyboardCollectionViewCell")

        self.numericKeyboardView.delegate = self
        self.numericKeyboardView.dataSource = self
    }

    private func setUpMeterialPicker() {
        let view = MeterialPickerView(frame: meterialPickerView.bounds)
        meterialPickerView.addSubview(view)
        view.myView?.delegate = self
    }

    @IBAction func showNumericKeyboard(_ sender: Any) {
        setupNumericKeyboard()
        numericKeyboardView.isHidden = false
        meterialPickerView.isHidden = true
    }

    @IBAction func showMeterialPicker(_ sender: Any) {
        setUpMeterialPicker()
        numericKeyboardView.isHidden = true
        meterialPickerView.isHidden = false
    }
}

extension CalculatorViewController: UICollectionViewDataSource {
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

extension CalculatorViewController: UICollectionViewDelegate {

}

extension CalculatorViewController: UICollectionViewDelegateFlowLayout {
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

extension CalculatorViewController {
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

extension CalculatorViewController: MeterialPickerDelegate {
    func meterialSelected(row: Int, title: String) {
        meterialButton.setTitle(title, for: .normal)
        meterialButton.setTitleColor(UIColor.black, for: .normal)
    }

}
