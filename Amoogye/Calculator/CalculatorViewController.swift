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

    // 입력 버튼
    @IBOutlet weak var resPortionTextfield: UITextField!    // 변환 전 인분
    @IBOutlet weak var desPortionTextfield: UITextField!    // 변환 후 인분
    @IBOutlet weak var amountTextfield: UITextField!        // 양
    @IBOutlet weak var meterialButton: UIButton!            // 재료

    // 키보드
    @IBOutlet weak var numericKeyboardView: UICollectionView!
    @IBOutlet weak var meterialPickerView: UIView!

    // 재료 검색
    @IBOutlet weak var meterialSearchView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 최초 실행 시 모든 키보드 가리기
        hideKeyboards()
    }

    // 인분, 양
    @IBAction func numericClick(_ sender: Any) {
        setupNumericKeyboard()
        numericKeyboardView.isHidden = false
        meterialPickerView.isHidden = true
    }

    // 재료
    @IBAction func meterialClick(_ sender: Any) {
        setUpMeterialPicker()
        numericKeyboardView.isHidden = true
        meterialPickerView.isHidden = false
    }

    @IBAction func cancelButtonClick(_ sender: Any) {
        meterialSearchView.isHidden = true
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

    private func setupMeterialSearchView() {
        let view = MeterialSearchView(frame: meterialSearchView.bounds)
        meterialSearchView.addSubview(view)
        view.myView?.delegate = self
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

    func meterialSearchViewOpen() {
        meterialSearchView.isHidden = false
        setupMeterialSearchView()
    }

    func meterialSearchViewClose() {
        meterialSearchView.isHidden = true
    }
}

extension CalculatorViewController: MeterialSearchDelegate {
    func selectMeterial(name: String) {
        hideKeyboards()
        meterialButton.setTitle(name, for: .normal)
         meterialButton.setTitleColor(UIColor.black, for: .normal)
    }

    func closeSearchView() {
        meterialSearchViewClose()
    }
}
