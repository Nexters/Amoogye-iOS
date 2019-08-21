//
//  SearchView.swift
//  Amoogye
//
//  Created by 임수현 on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit

class MeterialSearchView: UIView {
    let cellIdentifier = "MeterialSearchResultCell"

    weak var delegate: MeterialSearchDelegate?

    @IBOutlet weak var searchBarView: UIView!        // 검색창 바탕
    @IBOutlet weak var searchTextField: UITextField! // 실제 검색창 입력 부분
    @IBOutlet weak var searchButton: UIButton!       // 검색 버튼
    @IBOutlet weak var tableView: UITableView!       // 검색 결과
    @IBOutlet weak var hidedView: UIView!   // 키보드 영역만큼 올라올 부분

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTabelView()
        setupKeyboardToolbar()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupTabelView()
        setupKeyboardToolbar()
    }

    func setupView() {
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else {
            return
        }

        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds

        searchBarView.layer.cornerRadius = 6

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    func setupTabelView() {
        let nibCell = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: cellIdentifier)

        tableView.dataSource = self
        tableView.delegate = self
    }

    func setupKeyboardToolbar() {
        let keyboardToobar = UIToolbar()
        keyboardToobar.barTintColor = UIColor.white
        keyboardToobar.clipsToBounds = true
        keyboardToobar.tintColor = UIColor.amDarkBlueGrey
        keyboardToobar.sizeToFit()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelButtonClick))
        keyboardToobar.items = [flexibleSpace, btnCancel]

        searchTextField.inputAccessoryView = keyboardToobar
    }

    @objc func keyboardWillAppear(_ notification: Notification) {
        // 키보드 크기 구하기
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height

        // 키보드 크기만큼 뷰 위로 올려주기
        hidedView.snp.remakeConstraints { (make) in
            make.height.equalTo(keyboardHeight - 50)
        }
    }

    @IBAction func cancelButtonClick (sender: Any) { //click action...
        self.delegate?.closeSearchView()
    }
}

extension MeterialSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MeterialSearchResultCell
        cell.resultLabel.text = String(indexPath.row + 1)+"번 재료"
        cell.delegate = self.delegate
        return cell
    }
}

extension MeterialSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectMeterial(name: String(indexPath.row + 1)+"번 재료")
        delegate?.closeSearchView()
    }
}

protocol MeterialSearchDelegate: class {
    func selectMeterial(name: String)
    func closeSearchView()
}
